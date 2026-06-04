using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("USER_APPLICATION", Schema = "FCEO$KRNL")]
    public class UserApplication
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();  // RAW(16) -> GUID یا byte[]

        [Column("USER_APP_NAME")]
        [MaxLength(30)]
        public string? UserAppName { get; set; }

        [Column("USER_APP_DESC")]
        [MaxLength(100)]
        public string? UserAppDesc { get; set; }

        [Column("PASS_WORD")]
        [MaxLength(256)]
        public byte[]? PassWord { get; set; }  // هش شده

        [Column("SALT_KEY")]
        [MaxLength(32)]
        public byte[]? SaltKey { get; set; }

        [Column("PIN_CODE")]
        [MaxLength(256)]
        public byte[]? PinCode { get; set; }

        [Column("SMS_CODE")]
        [MaxLength(6)]
        public string? SmsCode { get; set; }

        [Column("QR_LINK_DEV_CODE")]
        [MaxLength(100)]
        public string? QrLinkDevCode { get; set; }

        [Column("STIC_2FA_CODE")]
        [MaxLength(256)]
        public byte[]? Stic2FaCode { get; set; }

        [Column("DYNC_2FA_CODE")]
        [MaxLength(100)]
        public string? Dync2FaCode { get; set; }

        [Column("TOTP_SCRT_KEY")]
        [MaxLength(64)]
        public string? TotpScrtKey { get; set; }

        [Column("TOTP_STAT")]
        [MaxLength(3)]
        public string? TotpStat { get; set; }  // 'YES'/'NO'

        [Column("LAST_USE_TIME")]
        public DateTime? LastUseTime { get; set; }

        [Column("LAST_TOTP_STEP")]
        public int? LastTotpStep { get; set; }

        [Column("FRST_LOGN_STAT")]
        [MaxLength(3)]
        public string? FrstLognStat { get; set; }

        [Column("MUST_CHNG_PASS")]
        [MaxLength(3)]
        public string? MustChngPass { get; set; }

        [Column("LAST_UPDT_PASS")]
        public DateTime? LastUpdtPass { get; set; }

        [Column("STAT")]
        [MaxLength(3)]
        public string? Stat { get; set; }

        [Column("CMNT")]
        [MaxLength(200)]
        public string? Cmnt { get; set; }

        [Column("PHON_NUMB")]
        [MaxLength(15)]
        public string? PhonNumb { get; set; }

        [Column("REGN_LANG")]
        [MaxLength(3)]
        public string? RegnLang { get; set; }

        [Column("EMAL_ADRS")]
        [MaxLength(254)]
        public string? EmalAdrs { get; set; }

        [Column("EMAL_VERF_STAT")]
        [MaxLength(3)]
        public string? EmalVerfStat { get; set; }

        [Column("FALD_LGIN_CONT")]
        public int? FaldLginCont { get; set; }

        [Column("LOCK_END_TIME")]
        public DateTime? LockEndTime { get; set; }

        [Column("CRET_BY")]
        [MaxLength(30)]
        public string? CretBy { get; set; }

        [Column("CRET_DATE")]
        public DateTime? CretDate { get; set; }

        [Column("MDFY_BY")]
        [MaxLength(30)]
        public string? MdfyBy { get; set; }

        [Column("MDFY_DATE")]
        public DateTime? MdfyDate { get; set; }

        [Column("DEL_BY")]
        [MaxLength(30)]
        public string? DelBy { get; set; }

        [Column("DEL_DATE")]
        public DateTime? DelDate { get; set; }

        [Column("VIEW_PAGE_SIZE")]
        public short? ViewPageSize { get; set; }

        [Column("USRA_CODE")]
        [MaxLength(16)]
        public byte[]? UsraCode { get; set; }

        [ForeignKey("UsraCode")]
        public virtual UserApplication? UsraCodeNavigation { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<UserApplication>? InverseUsraCodeNavigation { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<UserApplicationRole>? UserApplicationRoles { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<UserApplicationPrivilege>? UserApplicationPrivileges { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<UserRefreshToken>? UserRefreshTokens { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<UserNotification>? UserNotifications { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<UserImage>? UserImages { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<UserHostSession>? UserHostSessions { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<UserApplicationPaymentGateway>? UserApplicationPaymentGateways { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<SystemAudit>? SystemAudits { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<ConnectionString>? ConnectionStrings { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<GroupingUserApplication>? GroupingUserApplications { get; set; }

        [InverseProperty("UsraCodeNavigation")]
        public virtual ICollection<UserApplicationInstance>? UserApplicationInstances { get; set; }
    }
}
