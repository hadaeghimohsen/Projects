using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("PAYMENT_TRANSACTION", Schema = "FCEO$KRNL")]
    public class PaymentTransaction
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("PGAT_CODE")]
        [MaxLength(16)]
        public byte[]? PgatCode { get; set; }

        [Column("SYS_CODE")]
        [MaxLength(16)]
        public byte[]? SysCode { get; set; }

        [Column("RQST_RQID")]
        [MaxLength(16)]
        public byte[]? RqstRqid { get; set; }

        [Column("RQTP_CODE")]
        [MaxLength(3)]
        public string? RqtpCode { get; set; }

        [Column("RWNO")]
        public int? RwNo { get; set; }

        [Column("TRAN_DATE")]
        public DateTime? TranDate { get; set; }

        [Column("AMNT")]
        public decimal? Amnt { get; set; }

        [Column("PAY_STAT")]
        [MaxLength(3)]
        public string? PayStat { get; set; }

        [Column("ISSU_DATE")]
        public DateTime? IssuDate { get; set; }

        [Column("RESP_CODE")]
        [MaxLength(3)]
        public string? RespCode { get; set; }

        [Column("RESP_DESC")]
        [MaxLength(100)]
        public string? RespDesc { get; set; }

        [Column("TERM_NO")]
        [MaxLength(20)]
        public string? TermNo { get; set; }

        [Column("TRAN_NO")]
        [MaxLength(20)]
        public string? TranNo { get; set; }

        [Column("CARD_NO")]
        [MaxLength(16)]
        public string? CardNo { get; set; }

        [Column("FLOW_NO")]
        [MaxLength(20)]
        public string? FlowNo { get; set; }

        [Column("REF_NO")]
        [MaxLength(20)]
        public string? RefNo { get; set; }

        [Column("SERL_NO")]
        [MaxLength(20)]
        public string? SerlNo { get; set; }

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

        [ForeignKey("PgatCode")]
        public virtual PaymentGateway? PgatCodeNavigation { get; set; }

        [ForeignKey("SysCode")]
        public virtual SystemApplication? SysCodeNavigation { get; set; }
    }
}
