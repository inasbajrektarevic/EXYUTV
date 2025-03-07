using Iptv.Core;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Iptv.Services.Database
{
    public partial class DatabaseContext : IdentityDbContext<User, Role, int, UserClaim, UserRole, UserLogin, RoleClaim, UserToken>
    {
        public DbSet<Country> Countries { get; set; }
        public DbSet<City> Cities { get; set; }
        public DbSet<ActivityLog> Logs { get; set; }
        public DbSet<Application> Applications { get; set; }
        public DbSet<Channel> Channels { get; set; }
        public DbSet<ChannelCategory> ChannelCategories { get; set; }
        public DbSet<ChannelLanguage> ChannelLanguages { get; set; }
        public DbSet<DailyPackageRequest> DailyPackageRequests { get; set; }
        public DbSet<Device> Devices { get; set; }
        public DbSet<DeviceType> DeviceTypes { get; set; }
        public DbSet<DevicePackage> DevicePackages { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<Package> Packages { get; set; }
        public DbSet<PackageChannelCategory> PackageChannelCategories { get; set; }
        public DbSet<Payment> Payments { get; set; }
        public DbSet<UserChannel> UserChannels { get; set; }
        public DbSet<UserDevice> UserDevices { get; set; }
        public DbSet<UserPackageRequest> UserPackageRequests { get; set; }

        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            SeedData(modelBuilder);
            ApplyConfigurations(modelBuilder);
        }
    }
}
