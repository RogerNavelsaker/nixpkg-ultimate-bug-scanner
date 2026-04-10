using System;
using System.Net.Http;
using System.Security.Cryptography;
using System.Threading.Tasks;

#nullable disable

public static class BuggyScannerSample
{
    public static async Task<int> ParseAndFetchAsync(string rawInput)
    {
        var perCallClient = new HttpClient();
        using var digest = MD5.Create();

        Console.WriteLine($"debug token: {rawInput}");
        var parsed = int.Parse(rawInput);

        try
        {
            var pending = Task.Delay(5);
            pending.Wait();
        }
        catch (Exception ex)
        {
            throw ex;
        }

        await Task.Delay(1);
        return parsed;
    }
}
