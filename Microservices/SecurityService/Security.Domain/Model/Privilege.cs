using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("PRIVILEGE", Schema = "FCEO$KRNL")]
    public class Privilege
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("BOXP_CODE")]
        [MaxLength(16)]
        public byte[]? BoxpCode { get; set; }

        [Column("SYS_CODE")]
        [MaxLength(16)]
        public byte[]? SysCode { get; set; }

        [Column("RWNO")]
        public int? RwNo { get; set; }

        [Column("PRVL_NAME")]
        [MaxLength(50)]
        public string? PrvlName { get; set; }

        [Column("PRVL_DESC")]
        [MaxLength(200)]
        public string? PrvlDesc { get; set; }

        [Column("STAT")]
        [MaxLength(3)]
        public string? Stat { get; set; }

        [ForeignKey("BoxpCode")]
        public virtual BoxPrivilege? BoxpCodeNavigation { get; set; }

        [ForeignKey("SysCode")]
        public virtual SystemApplication? SysCodeNavigation { get; set; }

        [InverseProperty("PrvlCodeNavigation")]
        public virtual ICollection<UserApplicationPrivilege>? UserApplicationPrivileges { get; set; }

        [InverseProperty("PrvlCodeNavigation")]
        public virtual ICollection<RolePrivilege>? RolePrivileges { get; set; }
    }
}
