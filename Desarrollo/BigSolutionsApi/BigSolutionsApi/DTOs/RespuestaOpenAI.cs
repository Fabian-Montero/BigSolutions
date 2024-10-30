using System.Text.Json.Serialization;
using System.Collections.Generic;

namespace BigSolutionsApi.DTOs
{
    public class RespuestaOpenAI
    {
        [JsonPropertyName("created")]
        public long Created { get; set; }

        [JsonPropertyName("data")]
        public List<OpenAIData> Data { get; set; }

        public class OpenAIData
        {
            [JsonPropertyName("revised_prompt")]
            public string RevisedPrompt { get; set; }

            [JsonPropertyName("url")]
            public string Url { get; set; }

            [JsonPropertyName("b64_json")]
            public string b64_json { get; set; }


            
        }
    }
}
