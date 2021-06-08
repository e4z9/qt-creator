/****************************************************************************
**
** Copyright (C) 2019 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of Qt Creator.
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
****************************************************************************/

import QtQuick 2.0
import QtQuick3D 1.15
import MouseArea3D 1.0

PlanarDraggable {
    id: planarHandle
    scale: Qt.vector3d(0.024, 0.024, 0.024)

    property bool globalOrientation: false
    property vector3d axisX
    property vector3d axisY

    signal scaleCommit()
    signal scaleChange()

    property vector3d _startScale

    onPressed: {
        if (targetNode == multiSelectionNode)
            _generalHelper.restartMultiSelection();
        _startScale = targetNode.scale;
    }

    onDragged: (mouseArea, sceneRelativeDistance, relativeDistance)=> {
        targetNode.scale = mouseArea.getNewScale(_startScale, relativeDistance.times(scale.x),
                                                 axisX, axisY);
        if (targetNode == multiSelectionNode)
            _generalHelper.scaleMultiSelection(false);
        scaleChange();
    }

    onReleased: (mouseArea, sceneRelativeDistance, relativeDistance)=> {
        targetNode.scale = mouseArea.getNewScale(_startScale, relativeDistance.times(scale.x),
                                                 axisX, axisY);
        if (targetNode == multiSelectionNode)
            _generalHelper.scaleMultiSelection(true);
        scaleCommit();
    }
}
