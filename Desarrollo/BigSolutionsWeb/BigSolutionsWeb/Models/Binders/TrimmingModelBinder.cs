using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace BigSolutionsWeb.Models.Binders
{
    public class TrimmingModelBinder : IModelBinder
    {
        public Task BindModelAsync(ModelBindingContext bindingContext)
        {
            // Verifica si el modelo es de tipo string
            if (bindingContext.ModelType != typeof(string))
            {
                return Task.CompletedTask;
            }

            var valueProviderResult = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
            if (valueProviderResult == ValueProviderResult.None)
            {
                return Task.CompletedTask;
            }

            // Almacena el valor para actualizar el ModelState
            bindingContext.ModelState.SetModelValue(bindingContext.ModelName, valueProviderResult);
            var value = valueProviderResult.FirstValue;

            // Aplica el Trim si no es nulo
            if (!string.IsNullOrEmpty(value))
            {
                //Console.WriteLine("Value before trimming " + value + "." + "       Model name: " + bindingContext.ModelName);
                value = value.Trim();
                //Console.WriteLine("Value after trimming " + value + "." + "       Model name: " + bindingContext.ModelName);
            }

            bindingContext.Result = ModelBindingResult.Success(value);
            return Task.CompletedTask;
        }
    }
}