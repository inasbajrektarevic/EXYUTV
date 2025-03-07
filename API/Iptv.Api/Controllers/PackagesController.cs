using AutoMapper;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class PackagesController : BaseCrudController<PackageModel, PackageUpsertModel, PackagesSearchObject, IPackagesService>
    {
        private readonly IFileManager _fileManager;
        private readonly IRecommenderSystemsService _recommenderSystemsService;
        public PackagesController(IPackagesService service, IFileManager fileManager,
            IRecommenderSystemsService recommenderSystemsService, IMapper mapper, ILogger<PackagesController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
            _fileManager = fileManager;
            _recommenderSystemsService = recommenderSystemsService;
        }

        [HttpPost]
        public override async Task<IActionResult> Post([FromForm] PackageUpsertModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                model.Icon = GetFormFile();
                if (model.Icon != null)
                {
                    model.IconUrl = await _fileManager.UploadFileAsync(model.Icon);
                }
                model.CreatedById = 3;
                var result = await Service.AddAsync(model, cancellationToken);
                return Ok(result);

            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Problem when posting resource");
                return ValidationResult(e.Errors);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when posting resource");
                return BadRequest();
            }
        }

        [HttpPut]
        public override async Task<IActionResult> Put([FromForm] PackageUpsertModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                model.Icon = GetFormFile();
                if (model.Icon != null)
                {
                    model.IconUrl = await _fileManager.UploadFileAsync(model.Icon);
                }
                return Ok(await Service.UpdateAsync(model));
            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return ValidationResult(e.Errors);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return BadRequest();
            }
        }

        [HttpGet("RecommendByClientId/{clientId}")]
        public async Task<IActionResult> Recommend(int clientId)
        {
            return Ok(await _recommenderSystemsService.RecommendPackagesAsync(clientId));
        }
    }
}
