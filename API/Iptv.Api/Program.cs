using ePreschool.Shared.Models;
using Iptv.Api;
using Iptv.Core;
using Iptv.Services;
using Iptv.Services.Database;
using Iptv.Shared;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.Filters;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

var connectionStringConfig = builder.BindConfig<ConnectionStringConfig>("ConnectionStrings");

builder.Services.AddServices();
builder.Services.AddMapper();
builder.Services.AddLocalization();
builder.Services.AddValidators();
builder.Services.AddSwaggerViewer();
builder.Services.AddDatabase(connectionStringConfig);
builder.Services.AddOther();
builder.Services.AddUserIdentity(builder.Configuration);
builder.Services.AddSession();
builder.Services.AddHttpContextAccessor();
builder.Services.AddSignalR();
builder.Services.AddControllers();

builder.Services.AddCors(options =>
{
    options.AddPolicy("MyCorsPolicy", builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader();
    });
});

#region App

var app = builder.Build();

app.UseCors("MyCorsPolicy");
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
});
app.UseDeveloperExceptionPage();

app.UseHttpsRedirection();
app.UseSession();
app.UseAuthentication();
app.UseStaticFiles();

app.UseAuthorization();

app.MapControllers();

using var scope = app.Services.CreateScope();

var ctx = scope.ServiceProvider.GetRequiredService<DatabaseContext>();
ctx.Initialize();

await app.RunAsync();
#endregion
