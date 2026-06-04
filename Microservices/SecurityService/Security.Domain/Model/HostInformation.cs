using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("HOST_INFORMATION", Schema = "FCEO$KRNL")]
    public class HostInformation
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("DEV_NAME")]
        [MaxLength(200)]
        public string? DevName { get; set; }

        [Column("PLAT_FORM_TYPE")]
        [MaxLength(3)]
        public string? PlatFormType { get; set; }

        [Column("PLAT_FORM")]
        [MaxLength(100)]
        public string? PlatForm { get; set; }

        [Column("OS_TYPE")]
        [MaxLength(3)]
        public string? OsType { get; set; }

        [Column("OS_VERS")]
        [MaxLength(20)]
        public string? OsVers { get; set; }

        [Column("IP_ADRS")]
        [MaxLength(17)]
        public string? IpAdrs { get; set; }

        [Column("AGNT_DESC")]
        [MaxLength(100)]
        public string? AgntDesc { get; set; }

        [Column("APP_VER")]
        [MaxLength(17)]
        public string? AppVer { get; set; }

        [Column("MAC_ADRS")]
        [MaxLength(17)]
        public string? MacAdrs { get; set; }

        [Column("ACTV_STAT")]
        [MaxLength(3)]
        public string? ActvStat { get; set; }

        [Column("LAST_LGIN_DNRM")]
        public DateTime? LastLginDnrm { get; set; }

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

        [InverseProperty("HinfCodeNavigation")]
        public virtual ICollection<PaymentGateway>? PaymentGateways { get; set; }

        [InverseProperty("HinfCodeNavigation")]
        public virtual ICollection<UserHostSession>? UserHostSessions { get; set; }
    }
}
