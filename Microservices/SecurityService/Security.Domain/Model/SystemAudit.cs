using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("SYSTEM_AUDIT", Schema = "FCEO$KRNL")]
    public class SystemAudit
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();

        [Column("USRA_CODE")]
        [MaxLength(16)]
        public byte[]? UsraCode { get; set; }

        [Column("LOG_TYPE")]
        [MaxLength(3)]
        public string? LogType { get; set; }

        [Column("LOG_DESC")]
        [MaxLength(500)]
        public string? LogDesc { get; set; }

        [Column("CRET_BY")]
        [MaxLength(30)]
        public string? CretBy { get; set; }

        [Column("CRET_DATE")]
        public DateTime? CretDate { get; set; }

        [ForeignKey("UsraCode")]
        public virtual UserApplication? UsraCodeNavigation { get; set; }
    }
}
