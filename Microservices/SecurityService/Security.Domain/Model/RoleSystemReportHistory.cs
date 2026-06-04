using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("ROLE_SYSTEM_REPORT_HISTORY", Schema = "FCEO$KRNL")]
    public class RoleSystemReportHistory
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("RLSR_CODE")]
        [MaxLength(16)]
        public byte[]? RlsrCode { get; set; }

        [Column("CHNG_STAT")]
        [MaxLength(3)]
        public string? ChngStat { get; set; }

        [Column("CRET_BY")]
        [MaxLength(30)]
        public string? CretBy { get; set; }

        [Column("CRET_DATE")]
        public DateTime? CretDate { get; set; }

        [ForeignKey("RlsrCode")]
        public virtual RoleSystemReport? RlsrCodeNavigation { get; set; }
    }
}
