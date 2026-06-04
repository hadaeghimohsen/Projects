using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("APP_STATIC_DOMAIN", Schema = "FCEO$KRNL")]
    public class AppStaticDomain
    {
        [Column("CODE")]
        [MaxLength(20)]
        public string? Code { get; set; }

        [Column("NAME")]
        [MaxLength(100)]
        public string? Name { get; set; }

        [Column("RWNO")]
        public int? RwNo { get; set; }

        [Column("VALU")]
        [MaxLength(3)]
        public string? Valu { get; set; }

        [Column("DOMN_DESC")]
        [MaxLength(250)]
        public string? DomnDesc { get; set; }

        [Column("REGN_LANG")]
        [MaxLength(3)]
        public string? RegnLang { get; set; }
    }
}
