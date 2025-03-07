using Iptv.Core.Models;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using System.Data;

namespace Iptv.Services
{
    public class RecommenderSystemsService : IRecommenderSystemsService
    {
        static readonly SemaphoreSlim semaphore = new SemaphoreSlim(1, 1);
        private static MLContext mlContext;
        private static ITransformer model;
        private readonly IPackagesService _packageService;
        private readonly IUsersService _usersService;
        private readonly IOrdersService _ordersService;
        public RecommenderSystemsService(IPackagesService packageService, IUsersService usersService, IOrdersService ordersService)
        {
            _packageService = packageService;
            _usersService = usersService;
            _ordersService = ordersService;

        }

        public async Task<List<EntityItemModel>> RecommendPackagesAsync(int clientId)
        {
            try
            {
                await semaphore.WaitAsync();

                var client = await _usersService.GetByIdAsync(clientId);

                var birthDateYear = client!.BirthDate!.Value.Year;
                var clientsAgeRange = await _usersService.GetClientByBirthDateRange(birthDateYear - 5, birthDateYear + 5);
                var clientsAgeRangeIds = clientsAgeRange.Select(x => x.Id).ToList();
                var ordersFromClientsAgeRange = await _ordersService.GetByClientIds(clientsAgeRangeIds);
                var activePackages = await _packageService.GetActivePackages();

                if (!ordersFromClientsAgeRange.Any())
                {
                    return activePackages;
                }

                var packageOrderCounts = ordersFromClientsAgeRange
                    .GroupBy(x => x.PackageId)
                    .Select(group => new
                    {
                        PackageId = group.Key,
                        OrderCount = group.Count()
                    })
                    .ToList();

                var data = ordersFromClientsAgeRange.Select(x => new PackageNumber()
                {
                    ClientId = (uint)x.UserId,
                    PackageId = (uint)x.PackageId,
                    NumberOfOrder = packageOrderCounts.First(y => y.PackageId == x.PackageId).OrderCount
                });

                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    var options = new MatrixFactorizationTrainer.Options
                    {
                        MatrixColumnIndexColumnName = "ClientIdEncoded",
                        MatrixRowIndexColumnName = "PackageIdEncoded",
                        LabelColumnName = "NumberOfOrder",
                        NumberOfIterations = 20,
                        ApproximationRank = 100
                    };

                    var pipeline = mlContext.Transforms.Conversion.MapValueToKey(
                            inputColumnName: "ClientId",
                            outputColumnName: "ClientIdEncoded")
                        .Append(mlContext.Transforms.Conversion.MapValueToKey(
                            inputColumnName: "PackageId",
                            outputColumnName: "PackageIdEncoded")
                        .Append(mlContext.Recommendation().Trainers.MatrixFactorization(options)));

                    model = pipeline.Fit(traindata);
                }

                var predictionEngine = mlContext.Model.CreatePredictionEngine<PackageNumber, PackageNumberPrediction>(model);

                var top5 = (from e in activePackages
                            let p = predictionEngine.Predict(
                               new PackageNumber()
                               {
                                   ClientId = (uint)clientId,
                                   PackageId = (uint)e.Id,
                               })
                            orderby p.NumberOfOrder descending
                            select (PackageId: e.Id, Name: e.Label, Score: p.Score)).Take(5);
                return top5.Select(x => new EntityItemModel() { Id = x.PackageId, Label = x.Name }).ToList();
            }
            catch (Exception)
            {
                mlContext = null;
                return new List<EntityItemModel> { };
            }
            finally
            {
                semaphore.Release();
            }

        }

        public class PackageNumber
        {
            [KeyType(count: 10)]
            public uint ClientId { get; set; }
            [KeyType(count: 10)]
            public uint PackageId { get; set; }
            public float NumberOfOrder { get; set; }
        }

        public class PackageNumberPrediction
        {
            public float NumberOfOrder { get; set; }
            public float Score { get; set; }
        }
    }
}