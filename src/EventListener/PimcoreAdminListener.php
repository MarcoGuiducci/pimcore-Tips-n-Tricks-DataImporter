<?php
namespace App\EventListener;

use Pimcore\Event\BundleManager\PathsEvent;

class PimcoreAdminListener
{
    public function addCSSFiles(PathsEvent $event)
    {
        
    }

    public function addJSFiles(PathsEvent $event)
    {
        $event->setPaths(
            array_merge(
                $event->getPaths(),
                [
                    '/static/js/pimcore/data-importer/mapping/operator/caseConversion.js',
                ]
            )
        );
    }
}