using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("USER_REFRESH_TOKEN", Schema = "FCEO$KRNL")]
    public class UserRefreshToken
    {
        [Key]
        [Column("CODE")]
        [MaxLength(16)]
        public byte[] Code { get; set; } = Array.Empty<byte>();

        [Column("USRA_CODE")]
        [MaxLength(16)]
        public byte[]? UsraCode { get; set; }

        [Column("USON_CODE")]
        [MaxLength(16)]
        public byte[]? UsonCode { get; set; }

        [Column("TOKN_HASH")]
        [MaxLength(500)]
        public string? ToknHash { get; set; }

        [Column("TOKN_FMLY_CODE")]
        [MaxLength(16)]
        public byte[]? ToknFmlyCode { get; set; }

        [Column("ISSU_DATE")]
        public DateTime? IssuDate { get; set; }

        [Column("EXPR_DATE")]
        public DateTime? ExprDate { get; set; }

        [Column("REVK_DATE")]
        public DateTime? RevkDate { get; set; }

        [Column("REVK_RESN_TYPE")]
        [MaxLength(3)]
        public string? RevkResnType { get; set; }

        [Column("REVK_RESN_DESC")]
        [MaxLength(500)]
        public string? RevkResnDesc { get; set; }

        [Column("RPLC_BY_TOKN_CODE")]
        [MaxLength(16)]
        public byte[]? RplcByToknCode { get; set; }

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

        [ForeignKey("UsraCode")]
        public virtual UserApplication? UsraCodeNavigation { get; set; }

        [ForeignKey("ToknFmlyCode")]
        public virtual UserRefreshToken? ToknFmlyCodeNavigation { get; set; }

        [InverseProperty("ToknFmlyCodeNavigation")]
        public virtual ICollection<UserRefreshToken>? ReplacedByTokens { get; set; }

        [ForeignKey("RplcByToknCode")]
        public virtual UserRefreshToken? RplcByToknCodeNavigation { get; set; }
    }
}
