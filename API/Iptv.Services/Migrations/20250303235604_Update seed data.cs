using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Iptv.Services.Migrations
{
    /// <inheritdoc />
    public partial class Updateseeddata : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: 1,
                column: "ConcurrencyStamp",
                value: "9425426a-5ba9-442d-b6f2-13eaf5a8be66");

            migrationBuilder.UpdateData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: 2,
                column: "ConcurrencyStamp",
                value: "ab23f691-8bf2-44e4-aa6f-aa5d7f395d2a");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 1,
                column: "ConcurrencyStamp",
                value: "55da8c06-c62a-4f64-bc24-a1905cc327b8");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 2,
                column: "ConcurrencyStamp",
                value: "1e545580-a7fb-4dc7-9e07-4da3a782b103");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 3,
                column: "ConcurrencyStamp",
                value: "d0b61209-97de-405a-8aea-9105d70fa16a");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 4,
                column: "ConcurrencyStamp",
                value: "2293ef9d-b487-413b-8338-9771b15cb2c7");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 5,
                column: "ConcurrencyStamp",
                value: "fd2b06a6-b961-414e-8457-274fc27a2ab2");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 6,
                column: "ConcurrencyStamp",
                value: "7f4e9b11-9860-435f-880f-92feab7d972f");

            migrationBuilder.InsertData(
                table: "DeviceTypes",
                columns: new[] { "Id", "DateCreated", "DateUpdated", "IsDeleted", "Name" },
                values: new object[,]
                {
                    { 1, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, false, "Mobilni telefon" },
                    { 2, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, false, "TV" }
                });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1106), new DateTime(2025, 4, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1110) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1118), new DateTime(2025, 4, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1120) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1124), new DateTime(2025, 4, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1125) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1128), new DateTime(2025, 9, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1130) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1135), new DateTime(2025, 4, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1136) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1139), new DateTime(2025, 4, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1140) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 7,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1143), new DateTime(2025, 4, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1144) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 8,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1147), new DateTime(2025, 4, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1148) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 9,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1151), new DateTime(2025, 4, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1152) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 10,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1156), new DateTime(2025, 4, 4, 0, 56, 3, 804, DateTimeKind.Local).AddTicks(1157) });

            migrationBuilder.InsertData(
                table: "Devices",
                columns: new[] { "Id", "DateCreated", "DateUpdated", "DeviceTypeId", "IsDeleted", "Manufacturer", "Model", "Name", "SerialNumber" },
                values: new object[,]
                {
                    { 1, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, 1, false, "Samsung", "K48 556", "Samsung A52", "SA789555662555" },
                    { 2, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, 1, false, "Samsung", "K918 556", "Samsung Galaxy S24+", "SA7895554654662555" }
                });

            migrationBuilder.InsertData(
                table: "DailyPackageRequests",
                columns: new[] { "Id", "ApplicationId", "DateCreated", "DateTimeFrom", "DateTimeTo", "DateUpdated", "DeviceId", "Email", "FirstName", "IsDeleted", "LastName", "PhoneNumber", "Status" },
                values: new object[] { 1, 1, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), null, 1, "inas@gmail.com", "Inas", false, "Bajrektarević", "061552778", 2 });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "DailyPackageRequests",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "DeviceTypes",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Devices",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Devices",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "DeviceTypes",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.UpdateData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: 1,
                column: "ConcurrencyStamp",
                value: "143bbe2f-30ab-47de-a06a-a19cc8d61d69");

            migrationBuilder.UpdateData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: 2,
                column: "ConcurrencyStamp",
                value: "0bcd43dd-aa70-4aae-912f-50f4efc8c245");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 1,
                column: "ConcurrencyStamp",
                value: "ed987857-dc91-41f5-9a9a-176f0fe77e9c");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 2,
                column: "ConcurrencyStamp",
                value: "6853bac4-0d5e-4897-8a65-f9f022771f22");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 3,
                column: "ConcurrencyStamp",
                value: "d3ebc124-d900-4579-8d67-fff78c9c66cb");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 4,
                column: "ConcurrencyStamp",
                value: "f6366a87-4cbb-4bb3-955e-ba8790cc2bb7");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 5,
                column: "ConcurrencyStamp",
                value: "15caa726-1707-4a7b-8729-47907f44f000");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 6,
                column: "ConcurrencyStamp",
                value: "3c1bfd59-86e8-4144-b7ba-b8936523fb9e");

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1077), new DateTime(2025, 3, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1084) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1095), new DateTime(2025, 3, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1097) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1103), new DateTime(2025, 3, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1105) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1110), new DateTime(2025, 8, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1112) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1122), new DateTime(2025, 3, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1124) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1129), new DateTime(2025, 3, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1131) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 7,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1137), new DateTime(2025, 3, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1139) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 8,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1144), new DateTime(2025, 3, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1146) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 9,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1151), new DateTime(2025, 3, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1153) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 10,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1158), new DateTime(2025, 3, 28, 21, 52, 19, 468, DateTimeKind.Local).AddTicks(1160) });
        }
    }
}
