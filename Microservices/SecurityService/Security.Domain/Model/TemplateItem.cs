using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("TEMPLATE_ITEM", Schema = "FCEO$KRNL")]
    public class TemplateItem
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();

        [Column("TABL_NAME")]
        [MaxLength(128)]
        public string? TablName { get; set; }

        [Column("COLM_NAME")]
        [MaxLength(100)]
        public string? ColmName { get; set; }

        [Column("PLAC_HLDR")]
        [MaxLength(100)]
        public string? PlacHldr { get; set; }

        [Column("PLAC_DESC")]
        [MaxLength(100)]
        public string? PlacDesc { get; set; }

        [Column("RECD_STAT")]
        [MaxLength(3)]
        public string? RecdStat { get; set; }

        [Column("COLM_VALU_TYPE")]
        [MaxLength(3)]
        public string? ColmValuType { get; set; }

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
    }
}
