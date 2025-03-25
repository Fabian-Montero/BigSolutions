using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace BigSolutionsWeb.Models.Binders
{
    public class TrimmingModelBinderProvider : IModelBinderProvider
    {
        public IModelBinder? GetBinder(ModelBinderProviderContext context)
        {
            // Si el tipo es string, utiliza el TrimmingModelBinder
            if (context.Metadata.ModelType == typeof(string))
            {
                return new TrimmingModelBinder();
            }

            return null;
        }
    }
}