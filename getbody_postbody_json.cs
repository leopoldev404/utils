using System.Net.Http.Json;
using System.Text;
using System.Text.Json.Serialization;

StringBuilder stringBuilder = new();

string baseUrl = "";
string loginUrl = "";

HttpClient httpClient = new();

HttpResponseMessage responseMessage = await httpClient.PostAsJsonAsync(
    stringBuilder.Append(baseUrl).Append(loginUrl).ToString(),
    new LoginRequest("", "")
);

responseMessage.EnsureSuccessStatusCode();

var body = (await responseMessage.Content.ReadFromJsonAsync<LoginResponse>())!.Token;

// string fake = "https://jsonplaceholder.typicode.com/todos";
// HttpClient httpClient = new();

// HttpResponseMessage responseMessage = await httpClient.GetAsync(fake);
// responseMessage.EnsureSuccessStatusCode();
// List<TodoItem>? todoItems = await responseMessage.Content.ReadFromJsonAsync<List<TodoItem>>();
// todoItems?.ForEach(i => Console.WriteLine(i));

record LoginRequest(string Username, string Password);

record LoginResponse(
    [property: JsonPropertyName("esito")] int Code,
    [property: JsonPropertyName("token")] string Token
);

record TodoItem(
    [property: JsonPropertyName("userId")] int UserId,
    [property: JsonPropertyName("id")] int Id,
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("completed")] bool Completed
);
