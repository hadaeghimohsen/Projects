using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("ROLE_PRIVILEGE", Schema = "FCEO$KRNL")]
    public class RolePrivilege
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();

        [Column("ROLE_CODE")]
        [MaxLength(16)]
        public byte[]? RoleCode { get; set; }

        [Column("PRVL_CODE")]
        [MaxLength(16)]
        public byte[]? PrvlCode { get; set; }

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

        [ForeignKey("RoleCode")]
        public virtual Role? RoleCodeNavigation { get; set; }

        [ForeignKey("PrvlCode")]
        public virtual Privilege? PrvlCodeNavigation { get; set; }

        [InverseProperty("RolpCodeNavigation")]
        public virtual ICollection<RolePrivilegeHistory>? RolePrivilegeHistories { get; set; }
    }
}
