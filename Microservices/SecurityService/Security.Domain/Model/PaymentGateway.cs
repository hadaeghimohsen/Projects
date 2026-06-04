using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("PAYMENT_GATEWAY", Schema = "FCEO$KRNL")]
    public class PaymentGateway
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("HINF_CODE")]
        [MaxLength(16)]
        public byte[]? HinfCode { get; set; }

        [Column("PGAT_NAME")]
        [MaxLength(50)]
        public string? PgatName { get; set; }

        [Column("PGAT_TYPE")]
        [MaxLength(3)]
        public string? PgatType { get; set; }

        [Column("PSP_TYPE")]
        [MaxLength(3)]
        public string? PspType { get; set; }

        [Column("PGAT_DESC")]
        [MaxLength(100)]
        public string? PgatDesc { get; set; }

        [Column("PGAT_DFLT")]
        [MaxLength(3)]
        public string? PgatDflt { get; set; }

        [Column("PGAT_CNCT_TYPE")]
        [MaxLength(3)]
        public string? PgatCnctType { get; set; }

        [Column("IP_ADRS")]
        [MaxLength(15)]
        public string? IpAdrs { get; set; }

        [Column("COMM_PORT")]
        [MaxLength(15)]
        public string? CommPort { get; set; }

        [Column("PORT_NUMB")]
        public int? PortNumb { get; set; }

        [Column("PRNT_SALE")]
        [MaxLength(250)]
        public string? PrntSale { get; set; }

        [Column("PRNT_CUST")]
        [MaxLength(250)]
        public string? PrntCust { get; set; }

        [Column("AUTO_COMM")]
        [MaxLength(3)]
        public string? AutoComm { get; set; }

        [Column("ACNT_TYPE")]
        [MaxLength(3)]
        public string? AcntType { get; set; }

        [Column("BILL_FIND_TYPE")]
        [MaxLength(3)]
        public string? BillFindType { get; set; }

        [Column("BILL_NO")]
        [MaxLength(50)]
        public string? BillNo { get; set; }

        [Column("TERM_NO")]
        [MaxLength(20)]
        public string? TermNo { get; set; }

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

        [ForeignKey("HinfCode")]
        public virtual HostInformation? HinfCodeNavigation { get; set; }

        [InverseProperty("PgatCodeNavigation")]
        public virtual ICollection<UserApplicationPaymentGateway>? UserApplicationPaymentGateways { get; set; }

        [InverseProperty("PgatCodeNavigation")]
        public virtual ICollection<PaymentTransaction>? PaymentTransactions { get; set; }
    }
}
