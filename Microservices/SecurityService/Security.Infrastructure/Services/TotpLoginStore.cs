using System.Collections.Concurrent;
using Security.Application.Interfaces;

namespace Security.Infrastructure.Services;

public sealed class TotpLoginStore : ITotpLoginStore, IDisposable
{
    private readonly ConcurrentDictionary<string, TotpLoginEntry> _store = new();
    private readonly Timer _purgeTimer;
    private static readonly TimeSpan EntryTtl = TimeSpan.FromMinutes(5);
    private static readonly TimeSpan PurgeInterval = TimeSpan.FromMinutes(1);

    public TotpLoginStore()
    {
        _purgeTimer = new Timer(_ => PurgeExpired(), null, PurgeInterval, PurgeInterval);
    }

    public string Create(string username, string secret, string rememberMe)
    {
        var token = Convert.ToHexString(Guid.NewGuid().ToByteArray()).ToLowerInvariant();
        _store[token] = new TotpLoginEntry
        {
            Username = username,
            Secret = secret,
            RememberMe = rememberMe,
            ExpiresAt = DateTime.UtcNow.Add(EntryTtl)
        };
        return token;
    }

    public TotpLoginEntry? Consume(string token)
    {
        if (string.IsNullOrEmpty(token)) return null;
        if (!_store.TryGetValue(token, out var entry)) return null;
        if (entry.ExpiresAt < DateTime.UtcNow)
        {
            _store.TryRemove(token, out _);
            return null;
        }
        _store.TryRemove(token, out _);
        return entry;
    }

    public void PurgeExpired()
    {
        var now = DateTime.UtcNow;
        foreach (var kv in _store)
        {
            if (kv.Value.ExpiresAt < now)
                _store.TryRemove(kv.Key, out _);
        }
    }

    public void Dispose() => _purgeTimer.Dispose();
}
