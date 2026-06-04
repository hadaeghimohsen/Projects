using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("GROUPING_USER_APPLICATION", Schema = "FCEO$KRNL")]
    public class GroupingUserApplication
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("GROP_CODE")]
        [MaxLength(16)]
        public byte[]? GropCode { get; set; }

        [Column("USRA_CODE")]
        [MaxLength(16)]
        public byte[]? UsraCode { get; set; }

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

        [ForeignKey("GropCode")]
        public virtual Grouping? GropCodeNavigation { get; set; }

        [ForeignKey("UsraCode")]
        public virtual UserApplication? UsraCodeNavigation { get; set; }
    }
}
