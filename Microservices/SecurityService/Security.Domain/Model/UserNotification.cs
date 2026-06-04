using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("USER_NOTIFICATION", Schema = "FCEO$KRNL")]
    public class UserNotification
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("NEWS_CODE")]
        [MaxLength(16)]
        public byte[]? NewsCode { get; set; }

        [Column("USRA_CODE")]
        [MaxLength(16)]
        public byte[]? UsraCode { get; set; }

        [Column("NOTF_DESC")]
        [MaxLength(500)]
        public string? NotfDesc { get; set; }

        [Column("NOFT_NAME")]
        [MaxLength(100)]
        public string? NoftName { get; set; }

        [Column("READ_STAT")]
        [MaxLength(3)]
        public string? ReadStat { get; set; }

        [Column("PIN_STAT")]
        [MaxLength(3)]
        public string? PinStat { get; set; }

        [ForeignKey("NewsCode")]
        public virtual News? NewsCodeNavigation { get; set; }

        [ForeignKey("UsraCode")]
        public virtual UserApplication? UsraCodeNavigation { get; set; }
    }
}
