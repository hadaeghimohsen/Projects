using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("BOX_PRIVILEGE", Schema = "FCEO$KRNL")]
    public class BoxPrivilege
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("SYS_CODE")]
        [MaxLength(16)]
        public byte[]? SysCode { get; set; }

        [Column("BOXP_NAME")]
        [MaxLength(100)]
        public string? BoxpName { get; set; }

        [Column("BOXP_DESC")]
        [MaxLength(200)]
        public string? BoxpDesc { get; set; }

        [ForeignKey("SysCode")]
        public virtual SystemApplication? SysCodeNavigation { get; set; }

        [InverseProperty("BoxpCodeNavigation")]
        public virtual ICollection<Privilege>? Privileges { get; set; }
    }
}
