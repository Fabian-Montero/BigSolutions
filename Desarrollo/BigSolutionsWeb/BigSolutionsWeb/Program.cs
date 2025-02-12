using BigSolutionsWeb.Controllers;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Rotativa.AspNetCore;
using System.Text.Json;
using DotNetEnv;
using DotNetEnv.Configuration;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Variables de entorno
Env.Load();

// Agregar variables de entorno al ConfigurationBuilder
builder.Configuration
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.json", optional: true)
    .AddEnvironmentVariables();
    
var configuration = builder.Configuration;

// Configuraciones a sobrescribir
var environmentVariables = new Dictionary<string, string>
{
    { "Llaves:UrlApi", "URL_API" },
    { "Llaves:SecretKey", "SECRET_KEY" },

    { "FirebaseConfig:Email", "FIREBASE_EMAIL" },
    { "FirebaseConfig:Contrasenna", "FIREBASE_PASSWORD" },
    { "FirebaseConfig:Ruta", "FIREBASE_ROUTE" },
    { "FirebaseConfig:ApiKey", "FIREBASE_API_KEY" },

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


//inyeccion de dependencias

builder.Services.AddSession();
builder.Services.AddHttpContextAccessor();
builder.Services.AddHttpClient();
builder.Services.AddScoped<IComunesModel, ComunesModel>();
builder.Services.AddScoped<IUsuarioModel, UsuarioModel>();
builder.Services.AddScoped<IRolModel, RolModel>();
builder.Services.AddScoped<IFirebaseModel, FirebaseModel>();
builder.Services.AddScoped<IProductoModel, ProductoModel>();
builder.Services.AddScoped<ICategoriaModel, CategoriaModel>();
builder.Services.AddScoped<IBocetoModel, BocetoModel>();
builder.Services.AddScoped<ICotizacionesModel, CotizacionesModel>();
builder.Services.AddScoped<IOrdenModel, OrdenModel>();
builder.Services.AddScoped<IContabilidadModel, ContabilidadModel>();


// Inyección de dependencias para cerrar sesión por inactividad
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(10); // Establece el tiempo de inactividad a 10 minutos
    options.Cookie.HttpOnly = true; // Asegura que la cookie de sesión no sea accesible mediante JavaScript
    options.Cookie.IsEssential = true; // Asegura que la cookie se envíe incluso si el usuario no ha dado consentimiento
});

// Configura los servicios para los controladores y las vistas en la aplicación, para que así no pueda retroceder al de Inicio Sesión
builder.Services.AddControllersWithViews(options =>
{
    // Agrega el filtro global NoVolverAlLoginFiltro a todas las acciones
    // Este filtro se ejecutará antes de que se ejecute cualquier acción en los controladores
    // y garantiza que el usuario no pueda regresar a la página de inicio de sesión
    // si ya tiene una sesión activa (es decir, si tiene un "TOKEN" en la sesión)
    options.Filters.Add<NoVolverAlLoginFiltro>();
});

/*builder.Services.AddControllers().AddJsonOptions(options =>
{
    options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
});*/


//Rotativa 

RotativaConfiguration.Setup(builder.Environment.ContentRootPath, wkhtmltopdfRelativePath: "Rotativa/Windows");



var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseSession();
app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Usuario}/{action=InicioSesion}/{id?}");




app.Run();
