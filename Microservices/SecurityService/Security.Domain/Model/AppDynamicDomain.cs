using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("APP_DYNAMIC_DOMAIN", Schema = "FCEO$KRNL")]
    public class AppDynamicDomain
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("REF_CODE")]
        [MaxLength(16)]
        public byte[]? RefCode { get; set; }

        [Column("DOMN_NAME")]
        [MaxLength(100)]
        public string? DomnName { get; set; }

        [Column("DOMN_CMNT")]
        [MaxLength(100)]
        public string? DomnCmnt { get; set; }

        [Column("RWNO")]
        public int? RwNo { get; set; }

        [Column("NAME")]
        [MaxLength(100)]
        public string? Name { get; set; }

        [Column("DOMN_DESC")]
        [MaxLength(250)]
        public string? DomnDesc { get; set; }

        [Column("REGN_LANG")]
        [MaxLength(3)]
        public string? RegnLang { get; set; }

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

        [ForeignKey("RefCode")]
        public virtual AppDynamicDomain? RefCodeNavigation { get; set; }

        [InverseProperty("RefCodeNavigation")]
        public virtual ICollection<AppDynamicDomain>? InverseRefCodeNavigation { get; set; }
    }
}
