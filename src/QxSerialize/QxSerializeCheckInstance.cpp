/****************************************************************************
**
** http://www.qxorm.com/
** Copyright (C) 2013 Lionel Marty (contact@qxorm.com)
**
** This file is part of the QxOrm library
**
** This software is provided 'as-is', without any express or implied
** warranty. In no event will the authors be held liable for any
** damages arising from the use of this software
**
** Commercial Usage
** Licensees holding valid commercial QxOrm licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Lionel Marty
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file 'license.gpl3.txt' included in the
** packaging of this file. Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met : http://www.gnu.org/copyleft/gpl.html
**
** If you are unsure which license is appropriate for your use, or
** if you have questions regarding the use of this file, please contact :
** contact@qxorm.com
**
****************************************************************************/

#include <QxPrecompiled.h>

#include <QxSerialize/QxSerializeCheckInstance.h>

#include <QxMemLeak/mem_leak.h>

namespace qx {
namespace serialization {
namespace helper {

QSet< QPair<Qt::HANDLE, qptrdiff> > QxSerializeCheckInstance::m_lstInstanceByThread;

QxSerializeCheckInstance::QxSerializeCheckInstance(const void * pInstance) : m_pInstance(0), m_lThreadId(0)
{
   m_pInstance = reinterpret_cast<qptrdiff>(const_cast<void *>(pInstance));
   m_lThreadId = QThread::currentThreadId(); qAssert(m_pInstance != 0);
   m_lstInstanceByThread.insert(qMakePair(m_lThreadId, m_pInstance));
}

QxSerializeCheckInstance::~QxSerializeCheckInstance()
{
   m_lstInstanceByThread.remove(qMakePair(m_lThreadId, m_pInstance));
}

bool QxSerializeCheckInstance::contains(const void * pInstance)
{
   Qt::HANDLE lCurrThreadId = QThread::currentThreadId();
   qptrdiff iInstance = reinterpret_cast<qptrdiff>(const_cast<void *>(pInstance));
   return m_lstInstanceByThread.contains(qMakePair(lCurrThreadId, iInstance));
}

} // namespace helper
} // namespace serialization
} // namespace qx
