using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("USER_APPLICATION_ROLE_HISTORY", Schema = "FCEO$KRNL")]
    public class UserApplicationRoleHistory
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();

        [Column("UARL_CODE")]
        [MaxLength(16)]
        public byte[]? UarlCode { get; set; }

        [Column("CHNG_STAT")]
        [MaxLength(3)]
        public string? ChngStat { get; set; }

        [Column("CRET_BY")]
        [MaxLength(30)]
        public string? CretBy { get; set; }

        [Column("CRET_DATE")]
        public DateTime? CretDate { get; set; }

        [Column("CRET_HOST_BY")]
        [MaxLength(16)]
        public byte[]? CretHostBy { get; set; }

        [ForeignKey("UarlCode")]
        public virtual UserApplicationRole? UarlCodeNavigation { get; set; }
    }
}
