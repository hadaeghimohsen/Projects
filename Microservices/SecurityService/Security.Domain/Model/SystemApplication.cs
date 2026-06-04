using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("SYSTEM_APPLICATION", Schema = "FCEO$KRNL")]
    public class SystemApplication
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("SYS_NAME")]
        [MaxLength(50)]
        public string? SysName { get; set; }

        [Column("SYS_DESC")]
        [MaxLength(200)]
        public string? SysDesc { get; set; }

        [Column("RWNO")]
        public int? RwNo { get; set; }

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

        [InverseProperty("SysCodeNavigation")]
        public virtual ICollection<Role>? Roles { get; set; }

        [InverseProperty("SysCodeNavigation")]
        public virtual ICollection<Privilege>? Privileges { get; set; }

        [InverseProperty("SysCodeNavigation")]
        public virtual ICollection<BoxPrivilege>? BoxPrivileges { get; set; }

        [InverseProperty("SysCodeNavigation")]
        public virtual ICollection<Datasource>? Datasources { get; set; }

        [InverseProperty("SysCodeNavigation")]
        public virtual ICollection<MessageBox>? MessageBoxes { get; set; }

        [InverseProperty("SysCodeNavigation")]
        public virtual ICollection<PaymentTransaction>? PaymentTransactions { get; set; }
    }
}
