using Security.Domain.Interfaces;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using Oracle.ManagedDataAccess.Types;
using System.Text.Json;

namespace Security.Infrastructure.Repositories
{
    public class EXTR_USRA_PKG : IEXTR_USRA_SRVC
    {
        private readonly string _connectionString;

        public EXTR_USRA_PKG(string connectionString)
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

            using var command = new OracleCommand($"EXTR_USRA_PKG.{functionName}", connection)
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

        public async Task<string> INIT_USRA_U(string p_in)
            => await ExecuteFunctionAsync("INIT_USRA_U", p_in);

        public async Task<string> LGIN_USRA_U(string p_in)
            => await ExecuteFunctionAsync("LGIN_USRA_U", p_in);

        public async Task<string> LGOT_USRA_U(string p_in)
            => await ExecuteFunctionAsync("LGOT_USRA_U", p_in);

        public async Task<string> CRET_USRA_U(string p_in)
            => await ExecuteFunctionAsync("CRET_USRA_U", p_in);

        public async Task<string> REMV_USRA_U(string p_in)
            => await ExecuteFunctionAsync("REMV_USRA_U", p_in);

        public async Task<string> UPDT_USRA_U(string p_in)
            => await ExecuteFunctionAsync("UPDT_USRA_U", p_in);

        public async Task<string> ACTV_USRA_U(string p_in)
            => await ExecuteFunctionAsync("ACTV_USRA_U", p_in);

        public async Task<string> DACT_USRA_U(string p_in)
            => await ExecuteFunctionAsync("DACT_USRA_U", p_in);

        public async Task<string> UPDT_PSWD_U(string p_in)
            => await ExecuteFunctionAsync("UPDT_PSWD_U", p_in);

        public async Task<string> UPDT_PINC_U(string p_in)
            => await ExecuteFunctionAsync("UPDT_PINC_U", p_in);

        public async Task<string> DUPL_USRA_U(string p_in)
            => await ExecuteFunctionAsync("DUPL_USRA_U", p_in);

        public async Task<string> CHCK_PRIV_U(string p_in)
            => await ExecuteFunctionAsync("CHCK_PRIV_U", p_in);

        public async Task<string> ENBL_TOTP_U(string p_in)
            => await ExecuteFunctionAsync("ENBL_TOTP_U", p_in);

        public async Task<string> DSBL_TOTP_U(string p_in)
            => await ExecuteFunctionAsync("DSBL_TOTP_U", p_in);

        public async Task<string> GETP_USRA_U(string p_in)
            => await ExecuteFunctionAsync("GETP_USRA_U", p_in);

        public async Task<string> LIST_USRA_U(string p_in)
            => await ExecuteFunctionAsync("LIST_USRA_U", p_in);
    }
}