using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("SYSTEM_REPORT", Schema = "FCEO$KRNL")]
    public class SystemReport
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("SYSR_CODE")]
        [MaxLength(16)]
        public byte[]? SysrCode { get; set; }

        [Column("SYSR_NAME")]
        [MaxLength(100)]
        public string? SysrName { get; set; }

        [Column("CMNT")]
        [MaxLength(250)]
        public string? Cmnt { get; set; }

        [Column("PATH_ADRS")]
        [MaxLength(500)]
        public string? PathAdrs { get; set; }

        [Column("STAT")]
        [MaxLength(3)]
        public string? Stat { get; set; }

        [Column("RPRT_ENGN_TYPE")]
        [MaxLength(3)]
        public string? RprtEngnType { get; set; }

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

        [InverseProperty("SysrCodeNavigation")]
        public virtual ICollection<RoleSystemReport>? RoleSystemReports { get; set; }
    }
}
