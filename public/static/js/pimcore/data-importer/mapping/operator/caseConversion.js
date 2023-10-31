/**
 * Pimcore
 *
 * This source file is available under two different licenses:
 * - GNU General Public License version 3 (GPLv3)
 * - Pimcore Commercial License (PCL)
 * Full copyright and license information is available in
 * LICENSE.md which is distributed with this source code.
 *
 *  @copyright  Copyright (c) Pimcore GmbH (http://www.pimcore.org)
 *  @license    http://www.pimcore.org/license     GPLv3 and PCL
 */

pimcore.registerNS("pimcore.plugin.pimcoreDataImporterBundle.configuration.components.mapping.operator.caseConversion");
pimcore.plugin.pimcoreDataImporterBundle.configuration.components.mapping.operator.caseConversion = Class.create(pimcore.plugin.pimcoreDataImporterBundle.configuration.components.mapping.abstractOperator, {

    type: 'caseConversion',

    getFormItems: function () {
        return [
            {
                xtype: 'combo',
                fieldLabel: t('plugin_pimcore_datahub_data_importer_configpanel_transformation_pipeline_mode'),
                value: this.data.settings ? this.data.settings.caseConversion : 'strtolower',
                name: 'settings.caseConversion',
                listeners: {
                    change: this.inputChangePreviewUpdate.bind(this)
                },
                store: [
                    ['strtolower', t('plugin_pimcore_datahub_data_importer_configpanel_transformation_pipeline_strtolower')],
                    ['strtoupper', t('plugin_pimcore_datahub_data_importer_configpanel_transformation_pipeline_strtoupper')],
                    ['ucfirst', t('plugin_pimcore_datahub_data_importer_configpanel_transformation_pipeline_ucfirst')],
                    ['ucwords', t('plugin_pimcore_datahub_data_importer_configpanel_transformation_pipeline_ucwords')]
                ]

            }
        ];
    }

});