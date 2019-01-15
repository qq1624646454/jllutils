#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.qualcomm.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-09-10 11:14:05
#   ModifiedTime: 2018-09-10 11:14:49

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

高通的MSM是mobile station modems . 移动基带处理器.带基带的手机处理器.

QRD就是高通参考设计(Qualcomm Reference Design)

【ACR】Access control register
【AMSS】Advanced Mobile Subscriber Software
【APPS PBL】Application Processor Primary Boot Loader
【APQ】Application Processor Qualcomm
【APSS】Applications processor subsystem

【ASM】Anntena Switch Module

【BAM】Bus Access Manager

【BIMC】Bus integrated memory controller

【BLOB】Binary Large Object

【BLSP】BAM Low-Speed Peripherals

【BSP】Board support package
【CDT】Configuration Data Table，包含CDB0: platform info信息和CDB1: DDR配置参数
【CE】Crypto engine
【CV】customer visit
【DCVS】Dynamic clock and voltage scaling
【DDR】Double data rate
【DPC】Deferred procedure call
【EDL】Emergency Download
【FFA】Form Factor Accurate
【FFBM】fast factory boot mode
【FLCB】Fast Low Current Boot
【FSG】A golden file system有点不对劲
【HDET】High Power Detector有点不对劲
【Hexagon TCM】把Hexagon处理器用作紧耦合存储器，从软件角度，紧耦合存储器是一种物理内存，它的功能与一般内存没有什么差异。但是从硬件角度来说，紧耦合存储器能够从芯片中获得低延时的访问。
【IPO】instant power on
【L2 TCM】Tightly-Coupled Memory，紧耦合内存
【KDF】Key derivation function
【LPM】Low-power mode
【LPASS】Low power audio subsystem
【MBA】Modem Boot Authenticator
【MDM】Mobile Data Modem
【MDSS】Mobile display subsystem
【MMSS】Multimedia subsystem
【Modem PBL】Modem Primary Boot Loader
【modemst】modem efs partition有点不对劲
【MP】Modem processor
【MPM】MSM power manager
【MPQ】Media Processor Qualcomm
【MPSS】Modem peripheral subsystem software
【MSA】Modem Self-Authentication
【MSS】Modem subsystem两种解释，这个是来自高通文档
【MSS】Mobile Subscriber Software移动用户软件
【MVBAR】Monitor vector base address register
【NoC】Network-on-Chip片上网络是一种针对多核SoC设计的新型片上通信架构。对于传统共享总线通信结构中存在的延迟、通信性能瓶颈以及设计效率问题，NoC提供了一种新的片上通信结构解决方案。 
【OCMEM】On-chip memory
【PBM】Phonebook Manager
【PHK】Primary hardware key
【PIL】Peripheral image loader
【PMI】Primary Modem Image
【PnP】Plug and Play
【PRNG】Pseudorandom number generator
【QCA】Qualcomm Atheros
【QFE】Qualcomm Front-end
【QHEE】Qualcomm Hypervisor Execution Environment
【QRIB】QuAC reinitialization block
【QSAPPS】Qualcomm secure applications
【QSC】Qualcomm Single Chip
【QSD】Qualcomm Snapdragon
【QSEE】Qualcomm Secure Execution Environment
【QuAC】Qualcomm Access Control
【RFFE】Radio Frequency Front-end
【RPM】Resource Power Manager是高通MSM平台另外加的一块芯片，虽然与AP芯片打包在一起，但其是一个独立的ARM Core。之所以加这个东西，就是要控制整个电源相关的shared resources，比如ldo，clock。负责与SMP,MPM交互进入睡眠或者唤醒整个系统。
【RPM_FW】Resource Power Manager Firmware
【RTR】Radio Transceiver
【SAC】Secure access control
【SBL】Secondary Boot Loader
【SCM】Secure channel manager
【SDI】System Debug Image
【SFR】Subsystem RestartFailure Reason
【SFS】Secure file system
【SGI】Software Generated Interrupt
【SHK】Secondary hardware key
【SMC】Secure monitor call
【SMEM】shared memory
【SMMU】System memory management unit
【SoC】Systemon Chip
【SRLTE】Simultaneous  Radio and LTE
【SSD】Secure software download
【SSR】Subsystem Restart
【SURF】Subscriber Unit Reference Platform
【TLMM】Top-Level Mode Multiplexer，MSM TLMM pinmux controller，Qualcomm MSM integrates a GPIO and Pin mux/config hardware, (TOP Level Mode Multiplexer in short TLMM). It controls the input/output settings on the available pads/pins and also provides ability to multiplex and configure the output of various on-chip controllers onto these pads. The pins are also of different types, encapsulating different functions and having differing register semantics.
【TZ】ARM TrustZone
【TZBSP】TrustZone board support package
【VMIDMT】Virtual machine ID mapping table
【UniPro】Universal Protocol
【VBIF】video bus interface
【VFE】Video front-end
【WCD】wafer codec/decodec
【WCN】wireless connectivity network
【WCNSS】Wireless connectivity subsystem
【WTR】Wafer Transceiver
【XPU】Embedded Memory Protected Unit


附录：高通平台名相关
【CDP】Core Development Platform
【MTP】Modem Test Platform
【MSM】Mobile Station Modem
【QRD】Qualcomm Reference Design高通参考设计

 

 

lpass(Low Power Audio SubSystem) 低功耗音频子系统

Qualcomm LPASS QDSP6v5 Peripheral Image Loader

pil-qdsp6v5-lpass is a peripheral image loader (PIL) driver. It is used for
loading QDSP6v5 (Hexagon) firmware images for Low Power Audio Subsystems
into memory and preparing the subsystem’s processor to execute code.

参考资料 http://www.wdic.org/w/WDIC/MSM8960

MSM = Mobile Stattion Modem 集成芯片，包括通信处理器和应用处理器
MDM = Mobile Data Modem 通信处理器，高通提供给iPhone的就是这种
APQ = Application Processor Qualcomm 纯应用处理器，需要和MDM配合，才能组成手机系统

ARM-based mobile phone Dual-Mode Subscriber Station (DMSS)
Advanced Mode Subscriber Software (AMSS)

http://en.wikipedia.org/wiki/REX_OS

EDL (紧急下载模式）
adb reboot edl （使手机进入pbl紧急下载模式）
adb reboot dload （进入sbl1普通下载模式）

 

PBL：APPS PBL(Application Primary Boot Loader)，主引导加载程序
RPM：Resource Power Manager，资源电源管理器
RPM（Resource Power Manager）是高通MSM平台另外加的一块芯片，虽然与AP芯片打包在一起，但其是一个独立的ARM Core。之所以加这个东西，就是要控制整个电源相关的shared resources，比如ldo，clock。负责与SMP,MPM交互进入睡眠或者唤醒整个系统。
L2 TCM：Tightly-Coupled Memory，紧耦合内存
Some ARM SoC:s have a so-called TCM (Tightly-Coupled Memory). This is usually just a few (4-64) KiB of RAM inside the ARM processor. 
Due to being embedded inside the CPU The TCM has a Harvard-architecture, so there is an ITCM (instruction TCM) and a DTCM (data TCM). The DTCM can not contain any instructions, but the ITCM can actually contain data.


CDT: Configuration Data Table，包含CDB0: platform info信息和CDB1: DDR配置参数。
TZ:
PIL：Peripheral image loader
MBA:Modem Boot Authenticator，调制解调器引导认证
HLOS：High-level operation system，高级操作系统
Pronto image:


SMEM : shared memory
RPC : remote procedure call
QCSBL  : qualcomm second bootloader
OEMSBL  : oem second bootloader
AMSS    : Advanced Mobile Subscriber Software
SDI : System Debug Image
QSEE :  Qualcomm Secure Execution Environment
TZBSP  :  TrustZone BSP
SBL1：Scondary Boot Loader Stage1
MSS：Mobile Subscriber Software移动用户软件

 

WCD: wafer codec/decodec

WCN: wireless connectivity network

WTR: Wafer Transceiver

RTR: Radio Transceiver

QCA: Qualcomm Atheros

QFE: Qualcomm Front-end

RFFE: Radio Frequency Front-end

HDET: High Power Detector

ASM: Anntena Switch Module

MTP: Modem Test Platform

CDP: Core Development Platform

FFA: Form Factor Accurate

SURF: Subscriber Unit Reference Platform

XPU: Embedded Memory Protected Unit

UniPro: Universal Protocol

FLCB: Fast Low Current Boot

MSM: Mobile Station Modem

APQ: Application Processor Qualcomm

SRLTE: Simultaneous  Radio and LTE

 

QSD: Qualcomm Snapdragon

MDM: Mobile Data Modem

MPQ: Media Processor Qualcomm

QSC: Qualcomm Single Chip

PnP: Plug and Play

PBM: Phonebook Manager

FSG: A golden file system

modemst: modem efs partition

EDL: Emergency Download

mbn: Modem Configuration binary

CV: customer visit

FFBM: fast factory boot mode

IPO: instant power on



EOF

