// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

import { themes as prismThemes } from 'prism-react-renderer';

/** @type {import('@docusaurus/types').Config} */
const config = {
    title: 'VILLASframework',
    tagline: 'VILLASframework is a toolset for local and geographically distributed real-time co-simulation.',
    url: 'https://villas.fein-aachen.org',
    baseUrl: '/',
    favicon: 'img/logos/villas_framework.svg',
    organizationName: 'VILLASframework',
    projectName: 'Documentation',

    onBrokenLinks: 'throw',
    onBrokenAnchors: 'throw',
    onDuplicateRoutes: 'throw',

    markdown: {
        mermaid: true,
        hooks: {
            onBrokenMarkdownLinks: 'throw',
        }
    },

    plugins: [
        require.resolve('docusaurus-lunr-search'),
    ],

    presets: [
        [
            '@docusaurus/preset-classic',
            /** @type {import('@docusaurus/preset-classic').Options} */
            ({
                docs: {
                    sidebarPath: require.resolve('./sidebars.js'),
                    editUrl: 'https://github.com/VILLASframework/documentation/edit/master/',
                },
                blog: {
                    showReadingTime: true,
                    editUrl: 'https://github.com/VILLASframework/documentation/edit/master/',
                },
                theme: {
                    customCss: require.resolve('./src/css/custom.css'),
                },
            }),
        ],
        [
            'redocusaurus',
            {
                specs: [{
                    id: 'node',
                    route: '/api/node/',
                    spec: 'external/node/doc/openapi/openapi.yaml',
                },
                {
                    id: 'relay',
                    route: '/api/relay/',
                    spec: 'external/node/doc/openapi-relay.yaml',
                },
                {
                    id: 'controller',
                    route: '/api/controller/',
                    spec: 'external/controller/doc/openapi.yaml',
                },
                {
                    id: 'web',
                    route: '/api/web/',
                    // TODO this file is currently manually converter to OpenAPI spec v3
                    // See: https://github.com/VILLASframework/web-backend/tree/master/doc/api
                    spec: 'generated/web/openapi.yaml',
                },
                ],
            },
        ],
    ],

    themes: [
        '@docusaurus/theme-mermaid'
    ],

    themeConfig:
        /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
        ({
            navbar: {
                title: 'VILLASframework',
                logo: {
                    alt: 'VILLASframework logo',
                    src: 'img/logos/villas_framework.svg',
                },
                items: [{
                    type: 'doc',
                    docId: 'index',
                    position: 'left',
                    label: 'Documentation',
                },
                {
                    to: 'blog',
                    label: 'Blog',
                    position: 'left'
                },
                {
                    href: 'https://fein-aachen.org/',
                    label: 'FEIN Aachen e.V.',
                    position: 'right',
                },
                {
                    href: 'https://github.com/VILLASframework/',
                    label: 'GitHub',
                    position: 'right',
                },
                ],
            },
            footer: {
                logo: {
                    alt: 'RWTH Aachen',
                    src: 'img/logos/eonerc_dark.png',
                    href: 'https://acs.eonerc.rwth-aachen.de',
                },
                style: 'dark',
                links: [{
                    title: 'Docs',
                    items: [{
                        label: 'Documentation',
                        to: '/docs/',
                    }, {
                        label: 'FEIN Aachen e.V.',
                        href: 'https://www.fein-aachen.org',
                    },],
                },
                {
                    title: 'Community',
                    items: [{
                        label: 'RWTH Aachen University',
                        href: 'https://www.rwth-aachen.de',
                    },
                    {
                        label: 'E.ON Energy Research Center',
                        href: 'https://eonerc.rwth-aachen.de',
                    },
                    {
                        label: 'Institute for Automation of Complex Power Systems',
                        href: 'https://acs.eonerc.rwth-aachen.de',
                    },
                    ],
                },
                {
                    title: 'More',
                    items: [{
                        label: 'Blog',
                        to: '/blog',
                    },
                    {
                        label: 'GitHub',
                        href: 'https://github.com/VILLASframework',
                    },
                    ],
                },
                ],
                copyright: `Copyright © 2014-${new Date().getFullYear()} The VILLASframework Authors`,
            },
            prism: {
                theme: prismThemes.github,
                darkTheme: prismThemes.dracula,
            },
        }),
};

module.exports = config;
