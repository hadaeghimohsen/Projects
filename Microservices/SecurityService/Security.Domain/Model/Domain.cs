using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Security.Domain.Model
{
    public class DomainBase
    {
        [Key]
        [Column("VALU")]
        [MaxLength(3)]
        public string? Valu { get; set; }

        [Column("DOMN_DESC")]
        [MaxLength(100)]
        public string? DomnDesc { get; set; }
    }

    [Table("D$ACTV", Schema = "FCEO$KRNL")]
    public class D_ACTV : DomainBase { }

    [Table("D$ATYP", Schema = "FCEO$KRNL")]
    public class D_ATYP : DomainBase { }

    [Table("D$CONF", Schema = "FCEO$KRNL")]
    public class D_CONF : DomainBase { }

    [Table("D$CYCL", Schema = "FCEO$KRNL")]
    public class D_CYCL : DomainBase { }

    [Table("D$LOGT", Schema = "FCEO$KRNL")]
    public class D_LOGT : DomainBase { }

    [Table("D$PERM", Schema = "FCEO$KRNL")]
    public class D_PERM : DomainBase { }

    [Table("D$PMST", Schema = "FCEO$KRNL")]
    public class D_PMST : DomainBase { }

    [Table("D$RCST", Schema = "FCEO$KRNL")]
    public class D_RCST : DomainBase { }

    [Table("D$RGLN", Schema = "FCEO$KRNL")]
    public class D_RGLN : DomainBase { }

    [Table("D$WKDY", Schema = "FCEO$KRNL")]
    public class D_WKDY : DomainBase { }

    [Table("D$YSNO", Schema = "FCEO$KRNL")]
    public class D_YSNO : DomainBase { }
}
