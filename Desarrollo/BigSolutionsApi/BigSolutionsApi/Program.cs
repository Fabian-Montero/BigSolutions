using BigSolutionsApi.Modelos;
using Microsoft.OpenApi.Models;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Swashbuckle.AspNetCore.Filters;
using System.Text;
using DotNetEnv;

var builder = WebApplication.CreateBuilder(args);


// Add services to the container.

/*builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowWebApp",
        policy => policy.WithOrigins("https://app.bigsolutionscr.com",   // producción
                                    "https://localhost:7155",           // local HTTPS
                                    "http://localhost:5162")
                        .AllowAnyHeader()
                        .AllowAnyMethod());
});*/

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        policy => policy
            .AllowAnyOrigin()
            .AllowAnyHeader()
            .AllowAnyMethod());
});

builder.Services.AddControllers();
builder.Services.AddControllers().AddJsonOptions(x => { x.JsonSerializerOptions.PropertyNamingPolicy = null; });
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


//Variables de entorno

// Cargar variables de entorno desde el archivo .env
Env.Load();

// Construir la configuración asegurando que las variables de entorno sobrescriban `appsettings.json`
builder.Configuration
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.json", optional: true)
    .AddEnvironmentVariables();

var configuration = builder.Configuration;

// Lista de configuraciones a sobrescribir
var environmentVariables = new Dictionary<string, string>
{
    { "ConnectionStrings:SQLServerConnection", "SQLSERVER_CONNECTION" },

    { "Keys:SecretKey", "SECRET_KEY" },
    { "Keys:CorreoEmail", "CORREO_EMAIL" },
    { "Keys:ClaveEmail", "CLAVE_EMAIL" },

    { "FirebaseConfig:Email", "FIREBASE_EMAIL" },
    { "FirebaseConfig:Contrasenna", "FIREBASE_PASSWORD" },
    { "FirebaseConfig:Ruta", "FIREBASE_ROUTE" },
    { "FirebaseConfig:ApiKey", "FIREBASE_API_KEY" },

    { "OpenAI:ApiKey", "OPENAI_API_KEY" },
};

// Sobreescribir valores del `appsettings.json` con las variables de entorno
foreach (var setting in environmentVariables)
{
    string envValue = Environment.GetEnvironmentVariable(setting.Value);
    if (!string.IsNullOrEmpty(envValue))
    {
        builder.Configuration[setting.Key] = envValue;
    }
}

// Debugging
/*foreach (var setting in environmentVariables)
{
    Console.WriteLine($"[DEBUG] {setting.Key} (from Configuration): {configuration[setting.Key]}");
}*/


builder.Services.AddScoped<IComunesModel, ComunesModel>();
builder.Services.AddScoped<IFirebaseModel, FirebaseModel>();
builder.Services.AddSwaggerGen(options =>
{
    options.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme
    {
        Description = "Standard Authorization header using the Bearer scheme",
        In = ParameterLocation.Header,
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey
    });
    options.OperationFilter<SecurityRequirementsOperationFilter>();
});

string SecretKey = builder.Configuration["Keys:SecretKey"]!.ToString();

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateAudience = false,
        ValidateIssuer = false,
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(SecretKey)),
        ValidateLifetime = true,
        LifetimeValidator = (DateTime? notBefore, DateTime? expires, SecurityToken securityToken, TokenValidationParameters validationParameters) =>
        {
            if (expires != null)
            {
                return expires > DateTime.UtcNow;
            }
            return false;
        }
    };
});






var app = builder.Build();







// Configure the HTTP request pipeline.
/*if (app.Environment.IsDevelopment())
{*/
    app.UseSwagger();
    app.UseSwaggerUI();
/*}*/

/*app.UseHttpsRedirection();*/
app.UseRouting();
app.UseCors("AllowAll");
/*app.UseCors("AllowWebApp");
*/
app.UseAuthorization();

app.MapControllers();

app.Run();
