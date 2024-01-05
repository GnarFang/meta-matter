#!/bin/sh -x
#
# i.MX Yocto Project Build Environment Setup Script
#
# Copyright (C) 2011-2023 Freescale Semiconductor
# Copyright 2023 NXP
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of

# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

if [ ! -n "$MACHINE" ]; then
    MACHINE=imx8mmevk
fi
if [ ! -n "$OT_RCP_BUS" ]; then
    OT_RCP_BUS=UART
fi
echo "MACHINE = $MACHINE"
echo "OT_RCP_BUS = $OT_RCP_BUS"

EULA=$EULA DISTRO=$DISTRO MACHINE=$MACHINE . ./imx-setup-release.sh $@

if [ "$OT_RCP_BUS" = "SPI" ]; then
    echo "OT_RCP_BUS = \"SPI\"" >> conf/local.conf
fi
if [ "$OT_RCP_BUS" = "UART" ]; then
    echo "OT_RCP_BUS = \"UART\"" >> conf/local.conf
fi

echo "# layers for i.MX IoT for MATTER & OpenThread Border Router" >> conf/bblayers.conf
echo "BBLAYERS += \"\${BSPDIR}/sources/meta-matter\"" >> conf/bblayers.conf
echo "IMAGE_INSTALL:append = \" boost boost-dev boost-staticdev \"" >> conf/local.conf
echo "PACKAGECONFIG:append:pn-iptables = \" libnftnl\"" >> conf/local.conf

echo ""
echo "Now you can use below command to generate your image:"
echo "    $ bitbake imx-image-core"
echo "             or "
echo "    $ bitbake imx-image-multimedia"
echo "======================================================="
echo "If you want to generate SDK, please use:"
echo "    $ bitbake imx-image-core -c populate_sdk"
echo "To exit Matter build environment, please:"
echo "    $ deactivate"
echo ""
