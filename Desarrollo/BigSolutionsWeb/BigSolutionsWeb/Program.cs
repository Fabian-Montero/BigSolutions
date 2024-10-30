using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

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


// Inyecci�n de dependencias para cerrar sesi�n por inactividad
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(10); // Establece el tiempo de inactividad a 10 minutos
    options.Cookie.HttpOnly = true; // Asegura que la cookie de sesi�n no sea accesible mediante JavaScript
    options.Cookie.IsEssential = true; // Asegura que la cookie se env�e incluso si el usuario no ha dado consentimiento
});

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
