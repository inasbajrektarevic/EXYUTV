using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Iptv.Services.Migrations
{
    /// <inheritdoc />
    public partial class updatepackageentity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "IconUrl",
                table: "Packages",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "IconUrl",
                table: "Packages",
                type: "text",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: 1,
                column: "ConcurrencyStamp",
                value: "1565ceaa-76e9-47f4-b0ff-d774c1f79626");

            migrationBuilder.UpdateData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: 2,
                column: "ConcurrencyStamp",
                value: "fe06cd1b-54fd-424f-97b4-84b34afe3719");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 1,
                column: "ConcurrencyStamp",
                value: "01e43b95-2e22-4f5a-b94a-55eaa5b44484");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 2,
                column: "ConcurrencyStamp",
                value: "64c0ecdb-beb4-49b0-9de8-980c8c85ea38");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 3,
                column: "ConcurrencyStamp",
                value: "04d4f177-98c7-4b16-9509-8010cfb6a60e");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 4,
                column: "ConcurrencyStamp",
                value: "c11fe1ae-cf90-4ca8-a9e6-cc6d9240a890");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 5,
                column: "ConcurrencyStamp",
                value: "1455dc26-be90-452e-bffe-5cbd0f84b0cc");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 6,
                column: "ConcurrencyStamp",
                value: "e67ce5fe-fcfa-4164-b41a-f94730970c68");

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8042), new DateTime(2025, 3, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8044) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8052), new DateTime(2025, 3, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8053) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8057), new DateTime(2025, 3, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8058) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8062), new DateTime(2025, 8, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8063) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8068), new DateTime(2025, 3, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8070) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8073), new DateTime(2025, 3, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8074) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 7,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8079), new DateTime(2025, 3, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8080) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 8,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8083), new DateTime(2025, 3, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8084) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 9,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8087), new DateTime(2025, 3, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8088) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 10,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 2, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8091), new DateTime(2025, 3, 28, 2, 48, 33, 177, DateTimeKind.Local).AddTicks(8093) });
        }
    }
}
