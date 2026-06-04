using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("USER_HOST_SESSION", Schema = "FCEO$KRNL")]
    public class UserHostSession
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; }

        [Column("HINF_CODE")]
        [MaxLength(16)]
        public byte[]? HinfCode { get; set; }

        [Column("USRA_CODE")]
        [MaxLength(16)]
        public byte[]? UsraCode { get; set; }

        [Column("APP_SNID")]
        [MaxLength(100)]
        public string? AppSnid { get; set; }

        [Column("LOG_IN_DATE")]
        public DateTime? LogInDate { get; set; }

        [Column("LOG_OUT_DATE")]
        public DateTime? LogOutDate { get; set; }

        [Column("LOG_SEEN_DATE")]
        public DateTime? LogSeenDate { get; set; }

        [Column("ACTV_STAT")]
        [MaxLength(3)]
        public string? ActvStat { get; set; }

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

        [ForeignKey("UsraCode")]
        public virtual UserApplication? UsraCodeNavigation { get; set; }
    }
}
