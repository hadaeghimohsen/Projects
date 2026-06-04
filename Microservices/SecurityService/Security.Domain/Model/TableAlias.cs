using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security.Domain.Model
{
    [Table("TABLE_ALIAS", Schema = "FCEO$KRNL")]
    public class TableAlias
    {
        [Column("TABL_NAME")]
        [MaxLength(128)]
        public string? TablName { get; set; }

        [Column("TABL_DESC")]
        [MaxLength(500)]
        public string? TablDesc { get; set; }

        [Column("ALIS_NAME")]
        [MaxLength(4)]
        public string? AlisName { get; set; }

        [Column("PROC_STAT")]
        [MaxLength(3)]
        public string? ProcStat { get; set; }
    }
}
