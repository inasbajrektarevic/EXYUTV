using FluentValidation;
using Iptv.Core.Models;
using Iptv.Services.Validators;
using Microsoft.Extensions.DependencyInjection;

namespace Iptv.Services
{
    public static class Registry
    {
        public static void AddServices(this IServiceCollection services)
        {
            services.AddScoped<ICitiesService, CitiesService>();
            services.AddScoped<ICountriesService, CountriesService>();
            services.AddScoped<IActivityLogsService, ActivityLogsService>();
            services.AddScoped<IApplicationsService, ApplicationsService>();
            services.AddScoped<IDevicesService, DevicesService>();
            services.AddScoped<IDeviceTypesService, DeviceTypesService>();
            services.AddScoped<IChannelsService, ChannelsService>();
            services.AddScoped<IChannelCategoriesService, ChannelCategoriesService>();
            services.AddScoped<IChannelLanguagesService, ChannelLanguagesService>();
            services.AddScoped<IDailyPackageRequestsService, DailyPackageRequestsService>();
            services.AddScoped<IOrdersService, OrdersService>();
            services.AddScoped<IPackagesService, PackagesService>();
            services.AddScoped<IPaymentsService, PaymentsService>();
            services.AddScoped<IUsersService, UsersService>();
            services.AddScoped<IRolesService, RolesService>();
            services.AddScoped<IDropdownService, DropdownService>();
            services.AddScoped<IRabbitMQProducer, RabbitMQProducer>();
            services.AddScoped<IRecommenderSystemsService, RecommenderSystemsService>();
        }

        public static void AddValidators(this IServiceCollection services)
        {
            services.AddScoped<IValidator<CityUpsertModel>, CityValidator>();
            services.AddScoped<IValidator<CountryUpsertModel>, CountryValidator>();
            services.AddScoped<IValidator<ActivityLogUpsertModel>, ActivityLogValidator>();
            services.AddScoped<IValidator<ApplicationUpsertModel>, ApplicationValidator>();
            services.AddScoped<IValidator<DeviceUpsertModel>, DeviceValidator>();
            services.AddScoped<IValidator<DeviceTypeUpsertModel>, DeviceTypeValidator>();
            services.AddScoped<IValidator<ChannelUpsertModel>, ChannelValidator>();
            services.AddScoped<IValidator<ChannelCategoryUpsertModel>, ChannelCategoryValidator>();
            services.AddScoped<IValidator<ChannelLanguageUpsertModel>, ChannelLanguageValidator>();
            services.AddScoped<IValidator<DailyPackageRequestUpsertModel>, DailyPackageRequestValidator>();
            services.AddScoped<IValidator<OrderUpsertModel>, OrderValidator>();
            services.AddScoped<IValidator<PackageUpsertModel>, PackageValidator>();
            services.AddScoped<IValidator<PaymentUpsertModel>, PaymentValidator>();
            services.AddScoped<IValidator<UserUpsertModel>, UserValidator>();
            services.AddScoped<IValidator<RoleUpsertModel>, RoleValidator>();
            services.AddScoped<IValidator<UserRoleUpsertModel>, UserRoleValidator>();
            services.AddScoped<IValidator<UserUpsertModel>, UserValidator>();
            services.AddScoped<IValidator<RoleUpsertModel>, RoleValidator>();
            services.AddScoped<IValidator<UserRoleUpsertModel>, UserRoleValidator>();
        }
    }
}
