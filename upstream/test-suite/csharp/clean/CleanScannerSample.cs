using System;
using System.Net.Http;
using System.Threading.Tasks;

public static class CleanScannerSample
{
    public static async Task<int?> ParseAndFetchAsync(string rawInput, HttpClient sharedClient)
    {
        if (!int.TryParse(rawInput, out var parsed))
        {
            return null;
        }

        using var request = new HttpRequestMessage(HttpMethod.Get, "https://example.com");
        using var response = await sharedClient.SendAsync(request).ConfigureAwait(false);
        response.EnsureSuccessStatusCode();
        return parsed;
    }
}
