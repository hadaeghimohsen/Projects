using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("DATASOURCE", Schema = "FCEO$KRNL")]
    public class Datasource
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();

        [Column("SYS_CODE")]
        [MaxLength(16)]
        public byte[]? SysCode { get; set; }

        [Column("HOST_IP_ADRS")]
        [MaxLength(50)]
        public string? HostIpAdrs { get; set; }

        [Column("PORT_NUMB")]
        public int? PortNumb { get; set; }

        [Column("SID")]
        [MaxLength(100)]
        public string? Sid { get; set; }

        [Column("ROOT_NAME")]
        [MaxLength(30)]
        public string? RootName { get; set; }

        [Column("ROOT_DESC")]
        [MaxLength(100)]
        public string? RootDesc { get; set; }

        [Column("SCHM_NAME")]
        [MaxLength(30)]
        public string? SchmName { get; set; }

        [Column("PASS_WORD")]
        [MaxLength(200)]
        public string? PassWord { get; set; }

        [Column("SALT_KEY")]
        [MaxLength(32)]
        public byte[]? SaltKey { get; set; }

        [Column("STAT")]
        [MaxLength(3)]
        public string? Stat { get; set; }

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

        [ForeignKey("SysCode")]
        public virtual SystemApplication? SysCodeNavigation { get; set; }

        [InverseProperty("DsrcCodeNavigation")]
        public virtual ICollection<ConnectionString>? ConnectionStrings { get; set; }
    }
}
