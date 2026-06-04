using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("ROLE_PRIVILEGE_HISTORY", Schema = "FCEO$KRNL")]
    public class RolePrivilegeHistory
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();

        [Column("ROLP_CODE")]
        [MaxLength(16)]
        public byte[]? RolpCode { get; set; }

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

        [ForeignKey("RolpCode")]
        public virtual RolePrivilege? RolpCodeNavigation { get; set; }
    }
}
