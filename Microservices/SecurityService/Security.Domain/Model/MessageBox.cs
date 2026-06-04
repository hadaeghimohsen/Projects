using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("MESSAGE_BOX", Schema = "FCEO$KRNL")]
    public class MessageBox
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("BRDC_CODE")]
        [MaxLength(16)]
        public byte[]? BrdcCode { get; set; }

        [Column("SYS_CODE")]
        [MaxLength(16)]
        public byte[]? SysCode { get; set; }

        [Column("BRDC_TYPE_DNRM")]
        [MaxLength(3)]
        public string? BrdcTypeDnrm { get; set; }

        [Column("SEND_DATE")]
        public DateTime? SendDate { get; set; }

        [Column("REF_CODE")]
        [MaxLength(16)]
        public byte[]? RefCode { get; set; }

        [Column("PHON_NUMB")]
        [MaxLength(11)]
        public string? PhonNumb { get; set; }

        [Column("CHAT_ID")]
        public long? ChatId { get; set; }

        [Column("MESG_TEXT")]
        public string? MesgText { get; set; }

        [Column("MESG_TYPE")]
        [MaxLength(3)]
        public string? MesgType { get; set; }

        [Column("STAT")]
        [MaxLength(3)]
        public string? Stat { get; set; }

        [Column("SERV_MESG_CODE")]
        public long? ServMesgCode { get; set; }

        [Column("EROR_CODE")]
        [MaxLength(10)]
        public string? ErorCode { get; set; }

        [Column("EROR_MESG")]
        [MaxLength(100)]
        public string? ErorMesg { get; set; }

        [Column("MESG_LENT")]
        public short? MesgLent { get; set; }

        [Column("SEND_TYPE")]
        [MaxLength(3)]
        public string? SendType { get; set; }

        [Column("BULK_NUMB")]
        public long? BulkNumb { get; set; }

        [Column("PAGE_NUMB_DNRM")]
        public short? PageNumbDnrm { get; set; }

        [Column("VIST_STAT")]
        [MaxLength(3)]
        public string? VistStat { get; set; }

        [Column("VIST_DATE")]
        public DateTime? VistDate { get; set; }

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

        [ForeignKey("BrdcCode")]
        public virtual BroadcastConfig? BrdcCodeNavigation { get; set; }

        [ForeignKey("SysCode")]
        public virtual SystemApplication? SysCodeNavigation { get; set; }
    }
}
