let C = ./conky/config/config.dhall

let filesystem =
      C.ModType.filesystem
        C.FileSystem::{
        , show_smart = True
        , fs_paths =
          [ { path = "/", name = "root" }
          , { path = "/boot", name = "boot" }
          , { path = "/home", name = "home" }
          , { path = "/mnt/data", name = "data0" }
          , { path = "/mnt/more_data", name = "data1" }
          , { path = "/tmp", name = "tmpfs" }
          ]
        }

let graphics =
      C.ModType.graphics
        C.Graphics::{
        , dev_power = "/sys/bus/pci/devices/0000:01:00.0/power/control"
        , show_temp = True
        , show_clock = True
        , show_gpu_util = True
        , show_mem_util = True
        , show_vid_util = False
        }

let memory =
      C.ModType.memory
        C.Memory::{
        , show_stats = True
        , show_swap = True
        , show_plot = True
        , table_rows = 10
        , geometry = C.MemGeo::{
          , plot = C.PlotGeo::{ height = 120, ticks_y = 10 }
          }
        }

let processor =
      C.ModType.processor
        C.Processor::{
        , core_rows = 2
        , core_padding = 0
        , show_stats = False
        , show_plot = True
        , table_rows = 10
        , geometry = C.ProcGeo::{
          , plot = C.PlotGeo::{ height = 120, ticks_y = 10 }
          }
        }

let readwrite =
      C.ModType.readwrite C.ReadWrite::{ devices = [ "sda", "nvme0n1" ] }

let toCol = \(bs : List C.Block) -> C.Column.CCol { blocks = bs, width = 436 }

let toPanel =
      \(cs : List C.Column) ->
        C.Panel.PPanel { columns = cs, margins = { x = 20, y = 10 } }

let layout =
      { anchor = { x = 12, y = 11 }
      , panels =
        [ toPanel
            [ toCol
                [ C.mod (C.ModType.system C.System::{=})
                , C.Block.Pad 42
                , C.mod graphics
                , C.Block.Pad 42
                , C.mod memory
                ]
            ]
        , C.Panel.PPad 10
        , toPanel
            [ toCol [ C.mod readwrite ]
            , C.Column.CPad 20
            , toCol [ C.mod (C.ModType.network C.Network::{=}) ]
            ]
        , C.Panel.PPad 10
        , toPanel
            [ toCol
                [ C.mod (C.ModType.pacman C.Pacman::{=})
                , C.Block.Pad 40
                , C.mod filesystem
                , C.Block.Pad 40
                , C.mod processor
                ]
            ]
        ]
      }

in  C.toConfig 1 1920 1080 C.Theme::{=} layout
