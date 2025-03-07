using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Iptv.Services.Migrations
{
    /// <inheritdoc />
    public partial class Updatechannelentity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "LogoUrl",
                table: "Channels",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.UpdateData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: 1,
                column: "ConcurrencyStamp",
                value: "09334675-70ba-4478-8952-1157d312e5ed");

            migrationBuilder.UpdateData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: 2,
                column: "ConcurrencyStamp",
                value: "691eaf56-f076-45fe-a386-624d0e735cf9");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 1,
                column: "ConcurrencyStamp",
                value: "9a0f5a62-ca46-4266-ada6-44f600623a21");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 2,
                column: "ConcurrencyStamp",
                value: "42c727aa-8060-44f9-856b-6af2463bf16a");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 3,
                column: "ConcurrencyStamp",
                value: "468c118f-4e29-4f63-a9ff-9f2a10fb874f");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 4,
                column: "ConcurrencyStamp",
                value: "3b2501d1-93e7-4b9a-a309-bf9674474793");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 5,
                column: "ConcurrencyStamp",
                value: "4c9336a3-3d0e-4d3e-bfc5-7c1093ed1b1f");

            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: 6,
                column: "ConcurrencyStamp",
                value: "9db76c89-608d-43a8-ad24-ab4b1883c2d7");

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5742), new DateTime(2025, 4, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5745) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5753), new DateTime(2025, 4, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5755) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5759), new DateTime(2025, 4, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5760) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5763), new DateTime(2025, 9, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5764) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5769), new DateTime(2025, 4, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5770) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5774), new DateTime(2025, 4, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5775) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 7,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5778), new DateTime(2025, 4, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5779) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 8,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5782), new DateTime(2025, 4, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5783) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 9,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5786), new DateTime(2025, 4, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5787) });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 10,
                columns: new[] { "DateFrom", "DateTo" },
                values: new object[] { new DateTime(2025, 3, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5791), new DateTime(2025, 4, 7, 0, 47, 9, 24, DateTimeKind.Local).AddTicks(5792) });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "LogoUrl",
                table: "Channels",
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
        }
    }
}
