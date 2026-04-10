using System.Threading.Tasks;

public static class AstRulePackBuggy
{
    public static async Task RunAsync(object gate)
    {
        Task.Run(() => 42);
        lock (gate)
        {
            await Task.Delay(1);
        }
    }
}
