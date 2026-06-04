using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("NEWS", Schema = "FCEO$KRNL")]
    public class News
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();

        [Column("NEWS_NAME")]
        [MaxLength(100)]
        public string? NewsName { get; set; }

        [Column("NEWS_DESC")]
        [MaxLength(500)]
        public string? NewsDesc { get; set; }

        [Column("URL")]
        [MaxLength(500)]
        public string? Url { get; set; }

        [Column("STAT")]
        [MaxLength(3)]
        public string? Stat { get; set; }

        [Column("SHOW_DATE")]
        public DateTime? ShowDate { get; set; }

        [Column("EXPR_DATE")]
        public DateTime? ExprDate { get; set; }

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

        [InverseProperty("NewsCodeNavigation")]
        public virtual ICollection<UserNotification>? UserNotifications { get; set; }
    }
}
