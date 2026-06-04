using Security.Domain.Interfaces;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using Oracle.ManagedDataAccess.Types;
using System.Text.Json;

namespace Security.Infrastructure.Repositories
{
    public class EXTR_BRDC_PKG : IEXTR_BRDC_SRVC
    {
        private readonly string _connectionString;

        public EXTR_BRDC_PKG(string connectionString)
        {
            _connectionString = connectionString;
        }

        private async Task<string> ExecuteFunctionAsync(string functionName, string jsonInput)
        {
            using var connection = new OracleConnection(_connectionString);
            await connection.OpenAsync();

            if (!string.IsNullOrEmpty(jsonInput))
            {
                try
                {
                    using var doc = JsonDocument.Parse(jsonInput);
                    var username = doc.RootElement.TryGetProperty("_username", out var u)
                        ? u.GetString()
                        : doc.RootElement.TryGetProperty("USER_APP_NAME", out var u2)
                            ? u2.GetString()
                            : null;
                    if (!string.IsNullOrEmpty(username))
                    {
                        using var ctxCmd = new OracleCommand(
                            "BEGIN APP_CNTX_PKG.SET_CNTX_P('userappname', :username); END;",
                            connection);
                        ctxCmd.Parameters.Add(new OracleParameter("username", OracleDbType.Varchar2, 100)
                        { Value = username });
                        await ctxCmd.ExecuteNonQueryAsync();
                    }
                }
                catch { }
            }

            using var command = new OracleCommand($"EXTR_BRDC_PKG.{functionName}", connection)
            {
                CommandType = CommandType.StoredProcedure,
                BindByName = true
            };

            var inParam = new OracleParameter("p_in", OracleDbType.Clob)
            {
                Value = jsonInput,
                Size = jsonInput?.Length ?? 0,
                Direction = ParameterDirection.Input
            };
            command.Parameters.Add(inParam);

            var returnParam = new OracleParameter("return_value", OracleDbType.Clob)
            {
                Direction = ParameterDirection.ReturnValue
            };
            command.Parameters.Add(returnParam);

            await command.ExecuteNonQueryAsync();

            string result = "{}";
            if (returnParam.Value != null && returnParam.Value is OracleClob clob)
            {
                if (clob.IsNull)
                    result = "{}";
                else
                    result = clob.Value?.ToString() ?? "{}";
            }
            return result;
        }

        public async Task<string> INIT_BRDC_U(string p_in)
            => await ExecuteFunctionAsync("INIT_BRDC_U", p_in);

        public async Task<string> CRET_BRDC_U(string p_in)
            => await ExecuteFunctionAsync("CRET_BRDC_U", p_in);

        public async Task<string> REMV_BRDC_U(string p_in)
            => await ExecuteFunctionAsync("REMV_BRDC_U", p_in);

        public async Task<string> UPDT_BRDC_U(string p_in)
            => await ExecuteFunctionAsync("UPDT_BRDC_U", p_in);

        public async Task<string> LIST_BRDC_U(string p_in)
            => await ExecuteFunctionAsync("LIST_BRDC_U", p_in);
    }
}
