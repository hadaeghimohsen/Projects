using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("ROLE", Schema = "FCEO$KRNL")]
    public class Role
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();

        [Column("SYS_CODE")]
        [MaxLength(16)]
        public byte[]? SysCode { get; set; }

        [Column("ROLE_NAME")]
        [MaxLength(50)]
        public string? RoleName { get; set; }

        [Column("ROLE_DESC")]
        [MaxLength(200)]
        public string? RoleDesc { get; set; }

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

        [InverseProperty("RoleCodeNavigation")]
        public virtual ICollection<UserApplicationRole>? UserApplicationRoles { get; set; }

        [InverseProperty("RoleCodeNavigation")]
        public virtual ICollection<RolePrivilege>? RolePrivileges { get; set; }

        [InverseProperty("RoleCodeNavigation")]
        public virtual ICollection<RoleSystemReport>? RoleSystemReports { get; set; }
    }
}
