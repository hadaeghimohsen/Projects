using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("BROADCAST_CONFIG", Schema = "FCEO$KRNL")]
    public class BroadcastConfig
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("BRDC_TYPE")]
        [MaxLength(3)]
        public string? BrdcType { get; set; }

        [Column("BGWK_STAT")]
        [MaxLength(3)]
        public string? BgwkStat { get; set; }

        [Column("BGWK_INTR")]
        public int? BgwkIntr { get; set; }

        [Column("WEB_SITE")]
        [MaxLength(500)]
        public string? WebSite { get; set; }

        [Column("LOGN_TYPE")]
        [MaxLength(3)]
        public string? LognType { get; set; }

        [Column("USER_NAME")]
        [MaxLength(250)]
        public string? UserName { get; set; }

        [Column("PASS_WORD")]
        [MaxLength(250)]
        public string? PassWord { get; set; }

        [Column("WEB_SITE_LOGN")]
        [MaxLength(250)]
        public string? WebSiteLogn { get; set; }

        [Column("WEB_SITE_PSWD")]
        [MaxLength(250)]
        public string? WebSitePswd { get; set; }

        [Column("ACES_KEY")]
        [MaxLength(250)]
        public string? AcesKey { get; set; }

        [Column("SCRT_KEY")]
        [MaxLength(250)]
        public string? ScrtKey { get; set; }

        [Column("TOKN_CODE")]
        [MaxLength(250)]
        public string? ToknCode { get; set; }

        [Column("LINE_NUMB")]
        [MaxLength(50)]
        public string? LineNumb { get; set; }

        [Column("DFLT_STAT")]
        [MaxLength(3)]
        public string? DfltStat { get; set; }

        [Column("FTCH_ROW_NUMB")]
        public int? FtchRowNumb { get; set; }

        [Column("MIN_STOP_CHRG")]
        public int? MinStopChrg { get; set; }

        [Column("SERV_TYPE")]
        [MaxLength(3)]
        public string? ServType { get; set; }

        [Column("COMP_SNDR")]
        [MaxLength(200)]
        public string? CompSndr { get; set; }

        [Column("SLEP_INTR")]
        public int? SlepIntr { get; set; }

        [Column("PING_HOST")]
        [MaxLength(50)]
        public string? PingHost { get; set; }

        [Column("SEND_STAT")]
        [MaxLength(3)]
        public string? SendStat { get; set; }

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

        [InverseProperty("BrdcCodeNavigation")]
        public virtual ICollection<MessageBox>? Messageboxes { get; set; }
    }
}
