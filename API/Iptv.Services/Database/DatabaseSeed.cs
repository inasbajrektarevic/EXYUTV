using Iptv.Core;
using Iptv.Core.Models;
using Microsoft.EntityFrameworkCore;

namespace Iptv.Services.Database
{
    public partial class DatabaseContext
    {
        public void Initialize()
        {
            if (Database.GetAppliedMigrations()?.Count() == 0)
                Database.Migrate();
        }

        private readonly DateTime _dateTime = new(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Local);
        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedCountries(modelBuilder);
            SeedCities(modelBuilder);
            SeedUsers(modelBuilder);
            SeedRoles(modelBuilder);
            SeedUserRoles(modelBuilder);
            SeedApplications(modelBuilder);
            SeedDeviceTypes(modelBuilder);
            SeedDevices(modelBuilder);
            SeedDailyPackageRequests(modelBuilder);
            SeedChannelLanguages(modelBuilder);
            SeedChannelCategories(modelBuilder);
            SeedChannels(modelBuilder);
            SeedPackages(modelBuilder);
            SeedPackageChannelCategories(modelBuilder);
            SeedOrders(modelBuilder);
        }

        private void SeedCountries(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Country>().HasData(
                 new Country
                 {
                     Id = 1,
                     Abrv = "BiH",
                     DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                     IsActive = true,
                     IsDeleted = false,
                     Name = "Bosna i Hercegovina"
                 },
                  new Country
                  {
                      Id = 2,
                      Abrv = "HR",
                      DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                      IsActive = true,
                      IsDeleted = false,
                      Name = "Hrvatska"
                  },
                  new Country
                  {
                      Id = 3,
                      Abrv = "SRB",
                      DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                      IsActive = true,
                      IsDeleted = false,
                      Name = "Srbija"
                  },
                  new Country
                  {
                      Id = 4,
                      Abrv = "CG",
                      DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                      IsActive = true,
                      IsDeleted = false,
                      Name = "Crna Gora"
                  },
                new Country
                {
                    Id = 5,
                    Abrv = "MKD",
                    DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                    IsActive = true,
                    IsDeleted = false,
                    Name = "Makedonija"
                });

        }
        private void SeedCities(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<City>().HasData(
                new()
                {
                    Id = 1,
                    Name = "Mostar",
                    Abrv = "MO",
                    CountryId = 1,
                    IsActive = true,
                    DateCreated = _dateTime
                },
                new()
                {
                    Id = 2,
                    Name = "Sarajevo",
                    Abrv = "SA",
                    CountryId = 1,
                    IsActive = true,
                    DateCreated = _dateTime
                },
                new()
                {
                    Id = 3,
                    Name = "Jajce",
                    Abrv = "JC",
                    CountryId = 1,
                    IsActive = true,
                    DateCreated = _dateTime
                },
                new()
                {
                    Id = 4,
                    Name = "Tuzla",
                    Abrv = "TZ",
                    CountryId = 1,
                    IsActive = true,
                    DateCreated = _dateTime
                },
                new()
                {
                    Id = 5,
                    Name = "Zagreb",
                    Abrv = "ZG",
                    CountryId = 2,
                    IsActive = true,
                    DateCreated = _dateTime
                });
        }
        private void SeedUsers(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(
                new User
                {
                    Id = 1,
                    IsActive = true,
                    Email = "site.admin@exyutv.com",
                    NormalizedEmail = "SITE.ADMIN@EXYUTV.COM",
                    UserName = "site.admin",
                    NormalizedUserName = "SITE.ADMIN",
                    PasswordHash = "AQAAAAEAACcQAAAAEAGwZeqqUuR5X1kcmNbxwyTWxg2VDSnKdFTIFBQrQe5J/UTwcPlFFe6VkMa+yAmKgQ==", //Test1234
                    PhoneNumber = "38762123456",
                    ConcurrencyStamp = Guid.NewGuid().ToString(),
                    EmailConfirmed = true,
                    Address = "Mostar b.b",
                    BirthDate = new DateTime(1999, 5, 5),
                    FirstName = "Site",
                    LastName = "Admin",
                    Gender = Gender.Muški,
                    DateCreated = _dateTime
                },
                new User
                {
                    Id = 2,
                    IsActive = true,
                    Email = "client1@mail.com",
                    NormalizedEmail = "CLIENT1@MAIL.COM",
                    UserName = "client1",
                    NormalizedUserName = "CLIENT1",
                    PasswordHash = "AQAAAAEAACcQAAAAEAGwZeqqUuR5X1kcmNbxwyTWxg2VDSnKdFTIFBQrQe5J/UTwcPlFFe6VkMa+yAmKgQ==", //Test1234
                    PhoneNumber = "38762123456",
                    ConcurrencyStamp = Guid.NewGuid().ToString(),
                    EmailConfirmed = true,
                    Address = "Mostar b.b",
                    BirthDate = new DateTime(1999, 5, 5),
                    FirstName = "Inas",
                    LastName = "Bajraktarević",
                    Gender = Gender.Muški,
                    DateCreated = _dateTime
                },
                new User
                {
                    Id = 3,
                    IsActive = true,
                    Email = "client2@mail.com",
                    NormalizedEmail = "CLIENT2@MAIL.COM",
                    UserName = "client2",
                    NormalizedUserName = "CLIENT2",
                    PasswordHash = "AQAAAAEAACcQAAAAEAGwZeqqUuR5X1kcmNbxwyTWxg2VDSnKdFTIFBQrQe5J/UTwcPlFFe6VkMa+yAmKgQ==", //Test1234
                    PhoneNumber = "38762123456",
                    ConcurrencyStamp = Guid.NewGuid().ToString(),
                    EmailConfirmed = true,
                    Address = "Mostar b.b",
                    BirthDate = new DateTime(1979, 5, 5),
                    FirstName = "Client",
                    LastName = "2",
                    Gender = Gender.Muški,
                    DateCreated = _dateTime
                },
                new User
                {
                    Id = 4,
                    IsActive = true,
                    Email = "client3@mail.com",
                    NormalizedEmail = "CLIENT3@MAIL.COM",
                    UserName = "client3",
                    NormalizedUserName = "CLIENT3",
                    PasswordHash = "AQAAAAEAACcQAAAAEAGwZeqqUuR5X1kcmNbxwyTWxg2VDSnKdFTIFBQrQe5J/UTwcPlFFe6VkMa+yAmKgQ==", //Test1234
                    PhoneNumber = "38762123456",
                    ConcurrencyStamp = Guid.NewGuid().ToString(),
                    EmailConfirmed = true,
                    Address = "Mostar b.b",
                    BirthDate = new DateTime(1989, 5, 5),
                    FirstName = "Client",
                    LastName = "3",
                    Gender = Gender.Ženski,
                    DateCreated = _dateTime
                },
                new User
                {
                    Id = 5,
                    IsActive = true,
                    Email = "client4@mail.com",
                    NormalizedEmail = "CLIENT4@MAIL.COM",
                    UserName = "client4",
                    NormalizedUserName = "CLIENT4",
                    PasswordHash = "AQAAAAEAACcQAAAAEAGwZeqqUuR5X1kcmNbxwyTWxg2VDSnKdFTIFBQrQe5J/UTwcPlFFe6VkMa+yAmKgQ==", //Test1234
                    PhoneNumber = "38762123456",
                    ConcurrencyStamp = Guid.NewGuid().ToString(),
                    EmailConfirmed = true,
                    Address = "Mostar b.b",
                    BirthDate = new DateTime(2005, 5, 5),
                    FirstName = "Client",
                    LastName = "4",
                    Gender = Gender.Ženski,
                    DateCreated = _dateTime
                },
                new User
                {
                    Id = 6,
                    IsActive = true,
                    Email = "client5@mail.com",
                    NormalizedEmail = "CLIENT5@MAIL.COM",
                    UserName = "client5",
                    NormalizedUserName = "CLIENT5",
                    PasswordHash = "AQAAAAEAACcQAAAAEAGwZeqqUuR5X1kcmNbxwyTWxg2VDSnKdFTIFBQrQe5J/UTwcPlFFe6VkMa+yAmKgQ==", //Test1234
                    PhoneNumber = "38762123456",
                    ConcurrencyStamp = Guid.NewGuid().ToString(),
                    EmailConfirmed = true,
                    Address = "Mostar b.b",
                    BirthDate = new DateTime(2000, 5, 5),
                    FirstName = "Client",
                    LastName = "5",
                    Gender = Gender.Muški,
                    DateCreated = _dateTime
                }
            );
        }
        private void SeedRoles(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Role>().HasData(
                new Role
                {
                    Id = 1,
                    RoleLevel = RoleLevel.Administrator,
                    DateCreated = _dateTime,
                    Name = "Administrator",
                    NormalizedName = "ADMINISTRATOR",
                    ConcurrencyStamp = Guid.NewGuid().ToString()
                },
                 new Role
                 {
                     Id = 2,
                     RoleLevel = RoleLevel.Client,
                     DateCreated = _dateTime,
                     Name = "Client",
                     NormalizedName = "CLIENT",
                     ConcurrencyStamp = Guid.NewGuid().ToString()
                 }
            );
        }
        private void SeedUserRoles(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserRole>().HasData(
                new UserRole
                {
                    Id = 1,
                    DateCreated = _dateTime,
                    UserId = 1,
                    RoleId = 1
                },
                 new UserRole
                 {
                     Id = 2,
                     DateCreated = _dateTime,
                     UserId = 2,
                     RoleId = 2
                 },
                  new UserRole
                  {
                      Id = 3,
                      DateCreated = _dateTime,
                      UserId = 3,
                      RoleId = 2
                  },
                  new UserRole
                  {
                      Id = 4,
                      DateCreated = _dateTime,
                      UserId = 4,
                      RoleId = 2
                  },
                  new UserRole
                  {
                      Id = 5,
                      DateCreated = _dateTime,
                      UserId = 5,
                      RoleId = 2
                  },
                  new UserRole
                  {
                      Id = 6,
                      DateCreated = _dateTime,
                      UserId = 6,
                      RoleId = 2
                  }
            );
        }
        private void SeedApplications(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Application>().HasData(
                 new Application
                 {
                     Id = 1,
                     Name = "VLC media player",
                     DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified)
                 },
                  new Application
                  {
                      Id = 2,
                      Name = "Smart tv app",
                      DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified)
                  });

        }
        private void SeedDeviceTypes(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DeviceType>().HasData(
                 new DeviceType
                 {
                     Id = 1,
                     Name = "Mobilni telefon",
                     DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified)
                 },
                  new DeviceType
                  {
                      Id = 2,
                      Name = "TV",
                      DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified)
                  });

        }
        private void SeedDevices(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Device>().HasData(
                 new Device
                 {
                     Id = 1,
                     Name = "Samsung A52",
                     DeviceTypeId = 1,
                     Manufacturer = "Samsung",
                     Model = "K48 556",
                     SerialNumber = "SA789555662555",
                     DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified)
                 },
                 new Device
                 {
                     Id = 2,
                     Name = "Samsung Galaxy S24+",
                     DeviceTypeId = 1,
                     Manufacturer = "Samsung",
                     Model = "K918 556",
                     SerialNumber = "SA7895554654662555",
                     DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified)
                 }
            );
        }
        private void SeedDailyPackageRequests(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DailyPackageRequest>().HasData(
                 new DailyPackageRequest
                 {
                     Id = 1,
                     FirstName = "Inas",
                     LastName = "Bajrektarević",
                     PhoneNumber = "061552778",
                     Email = "inas@gmail.com",
                     DeviceId = 1,
                     ApplicationId = 1,
                     Status = UserPackageRequestStatus.InProcess,
                     DateCreated = new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified)
                 }
            );
        }
        private void SeedChannelLanguages(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ChannelLanguage>().HasData(
                new ChannelLanguage
                {
                    Id = 1,
                    DateCreated = _dateTime,
                    Name = "Bosanski",
                    CultureName = "bs-BA",
                    IsActive = true,
                },
                new ChannelLanguage
                {
                    Id = 2,
                    DateCreated = _dateTime,
                    Name = "Engleski",
                    CultureName = "en-US",
                    IsActive = true,
                }
            );
        }
        private void SeedChannelCategories(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ChannelCategory>().HasData(
                new ChannelCategory
                {
                    Id = 1,
                    DateCreated = _dateTime,
                    Name = "Filmski kanali",
                    Description = "Kategorija filmskih kanala",
                    IsActive = true,
                    OrderNumber = 1
                },
                new ChannelCategory
                {
                    Id = 2,
                    DateCreated = _dateTime,
                    Name = "Sportski kanali",
                    Description = "Kategorija sportskih kanala",
                    IsActive = true,
                    OrderNumber = 2
                },
                new ChannelCategory
                {
                    Id = 3,
                    DateCreated = _dateTime,
                    Name = "Muzicki kanali",
                    Description = "Kategorija muzičkih kanala",
                    IsActive = true,
                    OrderNumber = 3
                },
                new ChannelCategory
                {
                    Id = 4,
                    DateCreated = _dateTime,
                    Name = "Dokumentarni kanali",
                    Description = "Kategorija dokumentarnih kanala",
                    IsActive = true,
                    OrderNumber = 4
                },
                new ChannelCategory
                {
                    Id = 5,
                    DateCreated = _dateTime,
                    Name = "Djeciji kanali",
                    Description = "Kategorija dječijih kanala",
                    IsActive = true,
                    OrderNumber = 5
                },
                new ChannelCategory
                {
                    Id = 6,
                    DateCreated = _dateTime,
                    Name = "Informativni kanali",
                    Description = "Kategorija informativnih kanala",
                    IsActive = true,
                    OrderNumber = 6
                }
            );
        }
        private void SeedChannels(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Channel>().HasData(
                new Channel
                {
                    Id = 1,
                    DateCreated = _dateTime,
                    Name = "Action TV",
                    ChannelCategoryId = 1,
                    ChannelLanguageId = 1,
                    ChannelNumber = 1,
                    CountryId = 1,
                    Description = "Akcijski filmski kanal",
                    Frequency = 101,
                    IsHD = true,
                    LogoUrl = string.Empty,
                    Owner = "Action",
                    StreamUrl = "abcdefgh1234"
                },
                new Channel
                {
                    Id = 2,
                    DateCreated = _dateTime,
                    Name = "Sport HD",
                    ChannelCategoryId = 2,
                    ChannelLanguageId = 1,
                    ChannelNumber = 2,
                    CountryId = 1,
                    Description = "Sportski kanal sa HD prenosima",
                    Frequency = 102,
                    IsHD = true,
                    LogoUrl = string.Empty,
                    Owner = "Sport Network",
                    StreamUrl = "ijklmnop5678"
                },
                new Channel
                {
                    Id = 3,
                    DateCreated = _dateTime,
                    Name = "Music Hits",
                    ChannelCategoryId = 3,
                    ChannelLanguageId = 1,
                    ChannelNumber = 3,
                    CountryId = 1,
                    Description = "Muzicki kanal sa hitovima",
                    Frequency = 103,
                    IsHD = false,
                    LogoUrl = string.Empty,
                    Owner = "Music Media",
                    StreamUrl = "qrstuvwx9876"
                },
                new Channel
                {
                    Id = 4,
                    DateCreated = _dateTime,
                    Name = "Discovery World",
                    ChannelCategoryId = 4,
                    ChannelLanguageId = 1,
                    ChannelNumber = 4,
                    CountryId = 1,
                    Description = "Dokumentarni kanal sa zanimljivim sadržajem",
                    Frequency = 104,
                    IsHD = true,
                    LogoUrl = string.Empty,
                    Owner = "Discovery",
                    StreamUrl = "abc123xyz"
                },
                new Channel
                {
                    Id = 5,
                    DateCreated = _dateTime,
                    Name = "National Geographic",
                    ChannelCategoryId = 4,
                    ChannelLanguageId = 1,
                    ChannelNumber = 5,
                    CountryId = 1,
                    Description = "Kanal sa naučnim i dokumentarnim emisijama",
                    Frequency = 105,
                    IsHD = true,
                    LogoUrl = string.Empty,
                    Owner = "NatGeo",
                    StreamUrl = "def456uvw"
                },
                new Channel
                {
                    Id = 6,
                    DateCreated = _dateTime,
                    Name = "Cartoon Network",
                    ChannelCategoryId = 5,
                    ChannelLanguageId = 1,
                    ChannelNumber = 6,
                    CountryId = 1,
                    Description = "Dječiji kanal sa crtićima",
                    Frequency = 106,
                    IsHD = false,
                    LogoUrl = string.Empty,
                    Owner = "Warner Bros",
                    StreamUrl = "ghi789rst"
                },
                new Channel
                {
                    Id = 7,
                    DateCreated = _dateTime,
                    Name = "Nickelodeon",
                    ChannelCategoryId = 5,
                    ChannelLanguageId = 1,
                    ChannelNumber = 7,
                    CountryId = 1,
                    Description = "Dječiji kanal sa popularnim serijama",
                    Frequency = 107,
                    IsHD = false,
                    LogoUrl = string.Empty,
                    Owner = "Nickelodeon",
                    StreamUrl = "jkl012mno"
                },
                new Channel
                {
                    Id = 8,
                    DateCreated = _dateTime,
                    Name = "CNN",
                    ChannelCategoryId = 6,
                    ChannelLanguageId = 1,
                    ChannelNumber = 8,
                    CountryId = 1,
                    Description = "Informativni kanal sa svjetskim vijestima",
                    Frequency = 108,
                    IsHD = true,
                    LogoUrl = string.Empty,
                    Owner = "CNN Network",
                    StreamUrl = "pqr345stu"
                },
                new Channel
                {
                    Id = 9,
                    DateCreated = _dateTime,
                    Name = "BBC News",
                    ChannelCategoryId = 6,
                    ChannelLanguageId = 1,
                    ChannelNumber = 9,
                    CountryId = 1,
                    Description = "Britanski informativni kanal",
                    Frequency = 109,
                    IsHD = true,
                    LogoUrl = string.Empty,
                    Owner = "BBC",
                    StreamUrl = "vwx678yz"
                }
            );
        }
        private void SeedPackages(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Package>().HasData(
                new Package
                {
                    Id = 1,
                    Name = "Basic Paket",
                    Status = PackageStatus.Active,
                    IsPromotional = false,
                    RequiresSubscription = true,
                    Price = 9.99m,
                    Discount = null,
                    IconUrl = string.Empty,
                    Description = "Osnovni paket sa nekoliko osnovnih kanala.",
                    CreatedById = 1,
                    CountryId = 1
                },
                new Package
                {
                    Id = 2,
                    Name = "Sportski Paket",
                    Status = PackageStatus.Active,
                    IsPromotional = false,
                    RequiresSubscription = true,
                    Price = 14.99m,
                    Discount = 10,
                    IconUrl = string.Empty,
                    Description = "Paket sa sportskim kanalima i HD prenosima.",
                    CreatedById = 1,
                    CountryId = 1
                },
                new Package
                {
                    Id = 3,
                    Name = "Premium Paket",
                    Status = PackageStatus.Active,
                    IsPromotional = true,
                    RequiresSubscription = true,
                    Price = 29.99m,
                    Discount = 20,
                    IconUrl = string.Empty,
                    Description = "Paket sa premium kanalima i ekskluzivnim sadržajem.",
                    CreatedById = 1,
                    CountryId = 2
                },
                new Package
                {
                    Id = 4,
                    Name = "Family Paket",
                    Status = PackageStatus.Inactive,
                    IsPromotional = false,
                    RequiresSubscription = true,
                    Price = 19.99m,
                    Discount = null,
                    IconUrl = string.Empty,
                    Description = "Paket sa kanalima za celu porodicu.",
                    CreatedById = 1,
                    CountryId = 3
                },
                new Package
                {
                    Id = 5,
                    Name = "Exclusive Paket",
                    Status = PackageStatus.Active,
                    IsPromotional = false,
                    RequiresSubscription = true,
                    Price = 39.99m,
                    Discount = 15,
                    IconUrl = string.Empty,
                    Description = "Paket sa ekskluzivnim kanalima i sadržajem.",
                    CreatedById = 1,
                    CountryId = 1
                },
                new Package
                {
                    Id = 6,
                    Name = "Holiday Paket",
                    Status = PackageStatus.Active,
                    IsPromotional = true,
                    RequiresSubscription = false,
                    Price = 4.99m,
                    Discount = null,
                    IconUrl = string.Empty,
                    Description = "Promotivni paket za prazničnu sezonu sa besplatnim sadržajem.",
                    CreatedById = 1,
                    CountryId = 1
                }
            );
        }
        private void SeedPackageChannelCategories(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PackageChannelCategory>().HasData(
                new PackageChannelCategory
                {
                    Id = 1,
                    DateCreated = _dateTime,
                    PackageId = 1,
                    ChannelCategoryId = 1
                },
                new PackageChannelCategory
                {
                    Id = 2,
                    DateCreated = _dateTime,
                    PackageId = 1,
                    ChannelCategoryId = 3
                },
                new PackageChannelCategory
                {
                    Id = 3,
                    DateCreated = _dateTime,
                    PackageId = 2,
                    ChannelCategoryId = 2
                },
                new PackageChannelCategory
                {
                    Id = 4,
                    DateCreated = _dateTime,
                    PackageId = 2,
                    ChannelCategoryId = 4
                },
                new PackageChannelCategory
                {
                    Id = 5,
                    DateCreated = _dateTime,
                    PackageId = 3,
                    ChannelCategoryId = 1
                },
                new PackageChannelCategory
                {
                    Id = 6,
                    DateCreated = _dateTime,
                    PackageId = 3,
                    ChannelCategoryId = 2
                },
                new PackageChannelCategory
                {
                    Id = 7,
                    DateCreated = _dateTime,
                    PackageId = 3,
                    ChannelCategoryId = 3
                },
                new PackageChannelCategory
                {
                    Id = 8,
                    DateCreated = _dateTime,
                    PackageId = 3,
                    ChannelCategoryId = 4
                },
                new PackageChannelCategory
                {
                    Id = 9,
                    DateCreated = _dateTime,
                    PackageId = 3,
                    ChannelCategoryId = 5
                },
                new PackageChannelCategory
                {
                    Id = 10,
                    DateCreated = _dateTime,
                    PackageId = 4,
                    ChannelCategoryId = 5
                },
                new PackageChannelCategory
                {
                    Id = 11,
                    DateCreated = _dateTime,
                    PackageId = 4,
                    ChannelCategoryId = 3
                },
                new PackageChannelCategory
                {
                    Id = 12,
                    DateCreated = _dateTime,
                    PackageId = 5,
                    ChannelCategoryId = 1
                },
                new PackageChannelCategory
                {
                    Id = 13,
                    DateCreated = _dateTime,
                    PackageId = 5,
                    ChannelCategoryId = 2
                },
                new PackageChannelCategory
                {
                    Id = 14,
                    DateCreated = _dateTime,
                    PackageId = 5,
                    ChannelCategoryId = 4
                },
                new PackageChannelCategory
                {
                    Id = 15,
                    DateCreated = _dateTime,
                    PackageId = 6,
                    ChannelCategoryId = 3
                },
                new PackageChannelCategory
                {
                    Id = 16,
                    DateCreated = _dateTime,
                    PackageId = 6,
                    ChannelCategoryId = 5
                }
            );
        }
        private void SeedOrders(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Order>().HasData(
                new Order
                {
                    Id = 1,
                    Name = "O/1/2025",
                    Type = OrderType.Mjesečna,
                    Status = OrderStatus.Processing,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(1),
                    Note = "Prva narudžbina za Basic paket.",
                    Price = 9.99m,
                    Discount = null,
                    TotalPrice = 9.99m,
                    PackageId = 1,
                    UserId = 2
                },
                new Order
                {
                    Id = 2,
                    Name = "O/2/2025",
                    Type = OrderType.Mjesečna,
                    Status = OrderStatus.Completed,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(1),
                    Note = "Narudžbina za Sportski paket sa popustom.",
                    Price = 14.99m,
                    Discount = 1.50m,
                    TotalPrice = 13.49m,
                    PackageId = 2,
                    UserId = 3
                },
                new Order
                {
                    Id = 3,
                    Name = "O/3/2025",
                    Type = OrderType.Godišnja,
                    Status = OrderStatus.Processing,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(1),
                    Note = "Obnova Premium paketa.",
                    Price = 29.99m,
                    Discount = 5,
                    TotalPrice = 24.99m,
                    PackageId = 3,
                    UserId = 4
                },
                new Order
                {
                    Id = 4,
                    Name = "O/4/2025",
                    Type = OrderType.Mjesečna,
                    Status = OrderStatus.Confirmed,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(6),
                    Note = "Nov user sa Family paketom.",
                    Price = 20,
                    Discount = 2,
                    TotalPrice = 18,
                    PackageId = 4,
                    UserId = 5
                },
                new Order
                {
                    Id = 5,
                    Name = "O/5/2025",
                    Type = OrderType.Godišnja,
                    Status = OrderStatus.Processing,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(1),
                    Note = "Exclusive paket sa 15% popusta.",
                    Price = 39.99m,
                    Discount = 6m,
                    TotalPrice = 33.99m,
                    PackageId = 5,
                    UserId = 6
                },
                new Order
                {
                    Id = 6,
                    Name = "O/6/2025",
                    Type = OrderType.Mjesečna,
                    Status = OrderStatus.Completed,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(1),
                    Note = "Narudžbina za Basic paket.",
                    Price = 9.99m,
                    Discount = null,
                    TotalPrice = 9.99m,
                    PackageId = 1,
                    UserId = 3
                },
                new Order
                {
                    Id = 7,
                    Name = "O/7/2025",
                    Type = OrderType.Godišnja,
                    Status = OrderStatus.Completed,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(1),
                    Note = "Narudžbina za Premium paket sa popustom.",
                    Price = 29.99m,
                    Discount = 5,
                    TotalPrice = 24.99m,
                    PackageId = 3,
                    UserId = 2
                },
                new Order
                {
                    Id = 8,
                    Name = "O/8/2025",
                    Type = OrderType.Mjesečna,
                    Status = OrderStatus.Processing,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(1),
                    Note = "Narudžbina za Sportski paket.",
                    Price = 14.99m,
                    Discount = null,
                    TotalPrice = 14.99m,
                    PackageId = 2,
                    UserId = 5
                },
                new Order
                {
                    Id = 9,
                    Name = "O/9/2025",
                    Type = OrderType.Godišnja,
                    Status = OrderStatus.Completed,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(1),
                    Note = "Exclusive paket sa 10% popusta.",
                    Price = 39.99m,
                    Discount = 4,
                    TotalPrice = 35.99m,
                    PackageId = 5,
                    UserId = 4
                },
                new Order
                {
                    Id = 10,
                    Name = "O/10/2025",
                    Type = OrderType.Mjesečna,
                    Status = OrderStatus.Processing,
                    DateFrom = DateTime.Now,
                    DateTo = DateTime.Now.AddMonths(1),
                    Note = "Narudžbina za Family paket.",
                    Price = 20,
                    Discount = 2,
                    TotalPrice = 18,
                    PackageId = 4,
                    UserId = 6
                }
            );
        }
    }
}
